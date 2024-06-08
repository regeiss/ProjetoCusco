//
//  TabARouter.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 08/06/24.
//

import Foundation

@Observable class TabARouter: BaseRouter 
{
    enum TabADestination: String, RouterDestination, CaseIterable 
    {
        case viewOne
        case viewTwo

        var title: String 
        {
            return switch self 
            {
            case .viewOne:
                "View One"
            case .viewTwo:
                "View Two"
            }
        }
    }

    @ObservationIgnored override var routerDestinationTypes: [any RouterDestination.Type] 
    {
        return [TabADestination.self]
    }

    //MARK: - Public
    func navigate(to destination: TabADestination) 
    {
        path.append(destination)
    }
}
