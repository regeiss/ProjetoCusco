//
//  HomeScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 01/08/24.
//

import SwiftUI

struct HomeScreen: View
{
    var body: some View
    {
        ZStack
        {
            Image("login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.top)
           
        }
        Spacer()
        VStack {
            Button("Bordered Button") {
                
            }
            .buttonStyle(.bordered)
            .tint(.pink)
            
            Button("Bordered Prominent Button") {
                
            }
            .buttonStyle(.borderedProminent)

        }
        .font(.title2)
    }
}

#Preview {
    HomeScreen()
}
