//
//  ContentView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI
import SwiftfulRouting

enum Tabs: String, CaseIterable
{
    case home
    case matches
    case profile
    case pets
    case settings
}

struct ContentView: View
{
    @AppStorage("needsAppOnboarding") private var needsAppOnboarding: Bool = true
    @State private var selectedTab: Tabs = .home
    
    var body: some View
    {
        TabView(selection: $selectedTab)
        {
            HomeScreen()
                .tag(Tabs.home)
                .tabItem {
                    Image(systemName: "house")
                }
            
            PetListaScreen()
                .tag(Tabs.pets)
                .tabItem {
                    Image(systemName: "dog.fill")
                }
            
            MatchesScreen()
                .tag(Tabs.matches)
                .tabItem {
                    Image(systemName: "arrow.right.and.line.vertical.and.arrow.left")
                }
            AbrigoListaScreen()
                .tag(Tabs.settings)
                .tabItem {
                    Image(systemName: "map")
                }
            
            UserProfileView()
                .tag(Tabs.profile)
                .tabItem {
                    Image(systemName: "person")
                }
        }.toolbarBackground(.indigo, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
    }
}
