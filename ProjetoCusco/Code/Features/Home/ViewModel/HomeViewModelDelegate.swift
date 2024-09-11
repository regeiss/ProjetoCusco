//
//  HomeViewModelDelegate.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/08/24.
//
//
//import Foundation
//
//protocol HomeViewModelDelegate {
//    func fetchTitle() async throws -> String
//    func fetchSubtitle() async throws -> String
//    func fetchNextScreenTitle() async throws -> String
//}
//
//struct HomeViewModelDelegateProduction: HomeViewModelDelegate {
//    let service: DataService
//    
//    func fetchTitle() async throws -> String {
//        try await service.fetchTitle()
//    }
//    
//    func fetchSubtitle() async throws -> String {
//        try await service.fetchSubtitle()
//    }
//    
//    func fetchNextScreenTitle() async throws -> String {
//        try await service.fetchNextScreenTitle()
//    }
//}
//
//struct HomeViewModelDelegateMock: HomeViewModelDelegate {
//    func fetchTitle() async throws -> String {
//        "Alpha"
//    }
//    
//    func fetchSubtitle() async throws -> String {
//        "Beta"
//    }
//    
//    func fetchNextScreenTitle() async throws -> String {
//        "Gamma"
//    }
//}
//
//final class DataService {
//    
//    func fetchTitle() async throws -> String {
//        "Hello, world!"
//    }
//    
//    func fetchSubtitle() async throws -> String {
//        throw URLError(.badURL)
//    }
//    
//    func fetchNextScreenTitle() async throws -> String {
//        "My next screen!"
//    }
//}
