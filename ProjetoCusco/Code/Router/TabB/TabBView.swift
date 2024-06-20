//
//  TabBView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 19/06/24.
//
import SwiftUI

struct TabB: View 
{
    typealias Destination = TabBRouter.Destination
    typealias TransportationType = TransportationView.TransportationType

    private let navigationTitle = ContentView.Tab.tabb.title
    @Environment(TabBRouter.self) private var router

    // MARK: - Views
    var body: some View 
    {
        @Bindable var router = router

        NavigationStack(path: $router.path) 
        {
            listView
                .routerDestination(router: router,
                                   navigationBackTitle: navigationTitle,
                                   destination: navigationDestination)
                .navigationTitle(navigationTitle)
        }
    }

    @ViewBuilder private func navigationDestination(_ destination: Destination) -> some View 
    {
        switch destination 
        {
        case .transportation(let type):
            TransportationView(type: type)
        }
    }

    private var listView: some View 
    {
        List(TransportationType.allCases) 
        { type in
            Text(type.rawValue.capitalized)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture 
                {
                    router.navigate(to: .transportation(type: type))
                }
        }
    }
}
