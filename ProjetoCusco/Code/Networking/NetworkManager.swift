//
//  NetworkManager.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 16/06/24.
//

import Foundation
import UIKit

//
// https://rohitsainier.medium.com/building-a-robust-network-layer-in-ios-using-swift-660870e976a9
//

class NetworkManager {
    static let shared = NetworkManager()
    private let urlSession = URLSession.shared

    private init() {}

    func perform<T: Decodable>(_ request: NetworkRequest, decodeTo type: T.Type) async throws -> T {
        if #available(iOS 15.0, *) {
            let urlRequest = try request.urlRequest()
            let (data, response) = try await urlSession.data(for: urlRequest)
            try processResponse(response: response)
            return try decodeData(data: data, type: T.self)
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                perform(request, decodeTo: type) { result in
                    switch result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }

    private func decodeData<T: Decodable>(data: Data, type: T.Type) throws -> T {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch let decodingError {
            throw NetworkError.decodingFailed(decodingError)
        }
    }

    private func processResponse(response: URLResponse?) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200...299:
            return
        case 404:
            throw NetworkError.notFound
        case 500:
            throw NetworkError.internalServerError
        default:
            throw NetworkError.unknownError(statusCode: httpResponse.statusCode)
        }
    }

    func downloadFile(from url: URL) async throws -> URL {
        if #available(iOS 15.0, *) {
            let (localURL, response) = try await urlSession.download(from: url)
            try processResponse(response: response)
            return localURL
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                downloadFile(from: url) { result in
                    switch result {
                    case .success(let localURL):
                        continuation.resume(returning: localURL)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
}

extension NetworkManager {
    private func perform<T: Decodable>(_ request: NetworkRequest, decodeTo type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let urlRequest = try request.urlRequest()
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(.requestFailed(error)))
                    return
                }

                guard let data = data else {
                    completion(.failure(.dataNotFound))
                    return
                }

                do {
                    try self.processResponse(response: response)
                    let decodedObject = try self.decodeData(data: data, type: T.self)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error as? NetworkError ?? .invalidResponse))
                }
            }.resume()
        } catch {
            completion(.failure(error as? NetworkError ?? .invalidResponse))
        }
    }

    private func downloadFile(from url: URL, completion: @escaping (Result<URL, NetworkError>) -> Void) {
        urlSession.downloadTask(with: url) { localURL, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let localURL = localURL else {
                completion(.failure(.dataNotFound))
                return
            }

            do {
                try self.processResponse(response: response)
                completion(.success(localURL))
            } catch {
                completion(.failure(error as? NetworkError ?? .invalidResponse))
            }
        }.resume()
    }
}


