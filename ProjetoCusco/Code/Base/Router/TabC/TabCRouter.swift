//
//  TabCRouter.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 20/06/24.
//

import SwiftUI

@Observable class TabCRouter: BaseRouter 
{
    enum Destination: String, RouterDestination 
    {
        case inbox

        var title: String 
        {
            rawValue.capitalized
        }
    }

    // Nested views
    @ObservationIgnored override var routerDestinationTypes: [any RouterDestination.Type] 
    {
        return [Destination.self, InboxDestination.self]
    }

    // MARK: - Public
    func navigate(to destination: Destination)
    {
        path.append(destination)
    }
}

// MARK: - InboxRouterProtocol
extension TabCRouter: InboxNavigationProtocol
{
    func navigate(to destination: InboxDestination) 
    {
        path.append(destination)
    }
}

