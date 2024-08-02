//
//  DeeplinkManager.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 24/06/24.
//

import Foundation
import Combine

class DeeplinkManager
{
    enum DeeplinkType 
    {
        case chat
        case transportation(type: TransportationView.TransportationType)
    }
    
    static let shared = DeeplinkManager()
    
    let userActivityPublisher = PassthroughSubject<DeeplinkType, Never>()

    // MARK: - Lifecycle
    private init() {}
}
