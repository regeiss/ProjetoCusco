//
//  AuthenticationView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 14/07/24.
//

import SwiftUI
import Combine

struct AuthenticationView: View
{
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View
    {
        VStack
        {
            switch viewModel.flow
            {
            case .login:
                LoginView()
                    .environmentObject(viewModel)
            case .signUp:
                SignupView()
                    .environmentObject(viewModel)
            }
        }
    }
}
