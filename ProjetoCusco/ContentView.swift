//
//  ContentView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI

struct ContentView: View
{
    enum Tab
    {
        case taba
        case tabb
        case tabc
        case tabd

        var title: String
        {
            return switch self
            {
            case .taba:
                "Tab A"
            case .tabb:
                "Tab B"
            case .tabc:
                "Tab C"
            case .tabd:
                "Tab D"
            }
        }
    }

    @Environment(AppRouter.self) private var appRouter

    var body: some View
    {
        @Bindable var appRouter = appRouter

        TabView(selection: $appRouter.selectedTab)
        {
            TabA()
                .tag(Tab.taba)
                .environment(appRouter.tabARouter)
                .tabItem {
                    Image(systemName: "a.circle")
                }

            TabB()
                .tag(Tab.tabb)
                .environment(appRouter.tabBRouter)
                .tabItem {
                    Image(systemName: "b.circle")
                }

            TabC()
                .tag(Tab.tabc)
                .environment(appRouter.tabCRouter)
                .tabItem {
                    Image(systemName: "c.circle")
                }

            TabD()
                .tag(Tab.tabd)
                .environment(appRouter.tabDRouter)
                .tabItem {
                    Image(systemName: "d.circle")
                }
                .sheet(item: $appRouter.presentedSheet) {
                    appRouter.presentedSheet = nil
                } content: { presentedSheet in
                    view(for: presentedSheet)
                }
        }
        .onAppear
        {
            print("task    ======================")
            DeeplinkManager.shared.userActivityPublisher.send(.chat)
        }
        .environment(\.presentedSheet, $appRouter.presentedSheet)
        .environment(\.currentTab, $appRouter.selectedTab)
    }

    @ViewBuilder private func view(for presentedSheet: PresentedSheet) -> some View 
    {
        switch presentedSheet 
        {
        case .viewOne:
            ViewOne()
        case .transportation(let type):
            TransportationView(type: type)
        }
    }
}
