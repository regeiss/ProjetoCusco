//
//  AuthenticationView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 14/07/24.
//

import SwiftUI
import Combine

struct AuthenticationScreen: View
{
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View
    {
        VStack
        {
            switch viewModel.flow
            {
            case .login:
                LoginScreen()
                    .environmentObject(viewModel)
            case .signUp:
                SignupScreen()
                    .environmentObject(viewModel)
            }
        }
    }
}
