//
//  NetworkManager+Extensions.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 16/06/24.
//

import Foundation
import UIKit

extension NetworkManager 
{
    func downloadImage(from url: URL, cacheEnabled: Bool = true) async -> Result<UIImage, NetworkError> 
    {
        do 
        {
            if cacheEnabled, let cachedImage = try getCachedImage(for: url) 
            {
                return .success(cachedImage)
            }

            let localURL = try await NetworkManager.shared.downloadFile(from: url)
            let imageData = try Data(contentsOf: localURL)
            if let image = UIImage(data: imageData) {
                if cacheEnabled 
                {
                    cacheImage(imageData, for: url)
                }
                return .success(image)
            } 
            else
            {
                return .failure(.decodingFailed(DecodingErrorNetwork(message: "Failed to decode image data")))
            }
        } 
        catch
        {
            return .failure(error as? NetworkError ?? .invalidResponse)
        }
    }

    private func cacheImage(_ imageData: Data, for url: URL)
    {
        let cachedResponse = CachedURLResponse(response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!, data: imageData)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
        checkAndClearCache()
    }

    private func checkAndClearCache() 
    {
        let cacheSize = URLCache.shared.currentDiskUsage
        let cacheLimit: Int = 100 * 1024 * 1024 // 100 MB
        if cacheSize > cacheLimit {
            URLCache.shared.removeAllCachedResponses()
        }
    }

    private func getCachedImage(for url: URL) throws -> UIImage?
    {
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cachedResponse.data) {
            return image
        }
        return nil
    }
}
