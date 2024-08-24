//
//  HomeScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 01/08/24.
//

import SwiftUI
import SwiftfulRouting

struct HomeScreen: View
{
    @Environment(\.router) var router
    @AppStorage("needsAppOnboarding") var needsAppOnboarding = true
    @State private var isSettingsScreenPresented = false
    
    private var data = Pet.samples
    
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 185), spacing: 5),
        GridItem(.flexible(minimum: 100, maximum: 185), spacing: 5)
    ]
    
    var body: some View
    {
        RouterView { _ in
            
            ScrollView
            {
                LazyVGrid(columns: flexibleColumn, spacing: 5)
                {
                    ForEach(data) { pet in
                        HomeTileView(pet: pet)
                    }
                }
            }.navigationTitle("Home")
             .navigationBarTitleDisplayMode(.large)
        }
    }
}
