//
//  TabBRouter.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 17/06/24.
//

import SwiftUI

@Observable class TabBRouter: BaseRouter 
{
    typealias TransportationType = TransportationView.TransportationType

    enum Destination: RouterDestination 
    {
        case transportation(type: TransportationType)

        var description: String 
        {
            return switch self 
            {
            case .transportation(let type):
                "transportation(type: \(type))"
            }
        }
    }

    @ObservationIgnored override var routerDestinationTypes: [any RouterDestination.Type] 
    {
        return [Destination.self]
    }

    //MARK: - Public
    func navigate(to destination: Destination) 
    {
        path.append(destination)
    }
}

struct TransportationView: View 
{
    enum TransportationType: String, CaseIterable, Identifiable, Codable 
    {
        case airplane
        case car
        case bus
        case tram
        case cablecar
        case ferry
        case bicycle
        case scooter
        case sailboat

        var id: String 
        {
            return rawValue
        }
    }

    private let type: TransportationType

    // MARK: - Lifecycle
    init(type: TransportationType) 
    {
        self.type = type
    }

    // MARK: - Views
    var body: some View 
    {
        Image(systemName: type.rawValue)
            .font(.extraLargeTitle)
    }
}
