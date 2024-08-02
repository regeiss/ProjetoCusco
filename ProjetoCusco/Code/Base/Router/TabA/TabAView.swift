//
//  TabAView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 19/06/24.
//

import SwiftUI

struct TabA: View
{
    enum SheetItem: String, CaseIterable, Identifiable
    {
        case settings = "Settings"

        var id: String {
            return rawValue
        }
    }

    @AppStorage("needsAppOnboarding") var needsAppOnboarding = true
    @State private var isSettingsScreenPresented = false

    typealias Destination = TabARouter.TabADestination

    private let navigationTitle = ContentView.Tab.taba.title
    @Environment(TabARouter.self) private var router
    @Environment(\.presentedSheet) var presentedSheet

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
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: { didSelectSheetItem() })
                        {
                            Image(systemName: "gearshape")
                        }
                    }
                }
        }
    }

    @ViewBuilder private func navigationDestination(_ destination: Destination) -> some View
    {
        switch destination
        {
        case .viewOne:
            ViewOne()
        case .viewTwo:
            AbrigoListaScreen()
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
        .onAppear
        {
            if !needsAppOnboarding
            {
                presentedSheet.wrappedValue = .onBoarding
            }
            else
            {
                presentedSheet.wrappedValue = nil
            }
        }
        .sheet(isPresented: $isSettingsScreenPresented)
        {
            SettingsScreen()
        }
    }

    private func didSelectSheetItem()
    {
        presentedSheet.wrappedValue = .settings
    }

}
