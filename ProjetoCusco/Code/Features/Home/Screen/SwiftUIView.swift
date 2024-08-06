//
//  SwiftUIView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 03/08/24.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View
{
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var vm = GoogleSignInButtonViewModel()
    
    /// This is what does the trick with the customization
    init() {
        vm.style = .wide
        vm.scheme = .dark
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    GoogleSignInButton( action: {})
                        .accessibilityIdentifier("GoogleSignInButton")
                        .accessibility(hint: Text("Sign in with Google button."))
                        .padding()
                        
                }
            }
            Spacer()
        }
    }
}
//
//#Preview {
//    SignInView()
//}
