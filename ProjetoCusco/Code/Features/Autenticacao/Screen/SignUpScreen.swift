//
//  SignUpScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 15/07/24.
//

import SwiftUI
import Combine
import AuthenticationServices
import FirebaseAnalyticsSwift
import GoogleSignIn
import GoogleSignInSwift

private enum FocusableField: Hashable
{
    case email
    case password
    case confirmPassword
}

struct SignupScreen: View
{
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @FocusState private var focus: FocusableField?

    var body: some View
    {
        VStack
        {
            HStack
            {
                Text("Cusco App")
                    .font(.title)
                    .bold()
            }
            .padding(.horizontal)

            VStack
            {
                Image(colorScheme == .light ? "auth-hero-light" : "auth-hero-dark")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .padding(.vertical, 24)

                Text("Adote um pet.")
                    .font(.title2)
                    .padding(.bottom, 16)
            }

            Spacer()

            EmailLoginButtonView()

            HStack
            {
                Text("Já tem uma conta?")
                Button(action: { viewModel.switchFlow()})
                {
                    Text("Log in")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            .padding(.vertical, 8)
        }
        .padding()
        // .analyticsScreen(name: "\(Self.self)")
    }
}

#Preview
{
    Group
    {
        SignupScreen()
            .preferredColorScheme(.light)
    }
    .environmentObject(AuthenticationViewModel())
}
