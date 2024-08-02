//
//  ContentView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI

struct ContentView: View
{
    @Environment(AppRouter.self) private var appRouter
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true

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

    var body: some View
    {
        @Bindable var appRouter = appRouter

        TabView(selection: $appRouter.selectedTab)
        {
            TabA()
                .tag(Tab.taba)
                .environment(appRouter.tabARouter)
                .tabItem {
                    Image(systemName: "house")
                }
                .fullScreenCover(item: $appRouter.presentedSheet) {
                    appRouter.presentedSheet = nil
                } content: { presentedSheet in
                    view(for: presentedSheet)
                }

            TabB()
                .tag(Tab.tabb)
                .environment(appRouter.tabBRouter)
                .tabItem {
                    Image(systemName: "message")
                }

            TabC()
                .tag(Tab.tabc)
                .environment(appRouter.tabCRouter)
                .tabItem {
                    Image(systemName: "person")
                }

            TabD()
                .tag(Tab.tabd)
                .environment(appRouter.tabDRouter)
                .tabItem {
                    Image(systemName: "gear")
                }
                .sheet(item: $appRouter.presentedSheet) {
                    appRouter.presentedSheet = nil
                } content: { presentedSheet in
                    view(for: presentedSheet)
                }
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
        case .onBoarding:
            OnBoardingView()
        case .transportation(let type):
            TransportationView(type: type)
        case .settings:
            SettingsScreen()
        }
    }
}
