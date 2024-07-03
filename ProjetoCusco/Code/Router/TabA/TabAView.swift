//
//  TabAView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 19/06/24.
//

import SwiftUI

struct TabA: View
{
    @AppStorage("needsAppOnboarding") var needsAppOnboarding = true

    typealias Destination = TabARouter.TabADestination

    private let navigationTitle = ContentView.Tab.taba.title
    @Environment(TabARouter.self) private var router
    @Environment(\.presentedSheet) var presentedSheet

    // MARK: - Views
    var body: some View {
        @Bindable var router = router

        NavigationStack(path: $router.path) {
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
        case .viewOne:
            ViewOne()
        case .viewTwo:
            ViewTwo()
        }
    }

    private var listView: some View
    {
        List(Destination.allCases) { destination in
            Text(destination.title)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    router.navigate(to: destination)
                }
        }
        .onAppear{ if needsAppOnboarding {
            presentedSheet.wrappedValue = .onBoarding}
            else {
                presentedSheet.wrappedValue = nil }
        }
    }
}
