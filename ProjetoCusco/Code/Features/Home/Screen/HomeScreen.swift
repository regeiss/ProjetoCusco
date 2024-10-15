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
    @StateObject private var viewModel = PetViewModel()
    
    // @State private var isSettingsScreenPresented = false
    
    private let flexibleColumn = [
        GridItem(.flexible(minimum: 100, maximum: 195), spacing: 5),
        GridItem(.flexible(minimum: 100, maximum: 195), spacing: 5)
    ]
    
    var body: some View
    {
        RouterView { _ in
            
            ScrollView
            {
                LazyVGrid(columns: flexibleColumn, spacing: 5)
                {
                    ForEach(viewModel.pet) { pet in
                        HomeTileView(pet: pet)
                    }
                }
            }.navigationTitle("Home")
             .navigationBarTitleDisplayMode(.large)
             .background(Color.background)
        }
    }
}
