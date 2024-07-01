//
//  OnBoardingView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 25/06/24.
//

import SwiftUI

struct OnBoardingView: View
{
    @State private var currentTab = 0
     
    var body: some View
    {
        TabView(selection: $currentTab, content: {
            ForEach(OnboardingData.list) { viewData in
                OnboardingTabView(data: viewData)
                    .tag(viewData.id)
            }
        })
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
