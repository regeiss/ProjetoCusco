//
//  AuthenticationViewModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 15/07/24.
//

import AuthenticationServices
import Combine
import Factory
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

enum AuthenticationState
{
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow
{
    case login
    case signUp
}

enum AuthenticationError: Error
{
    case tokenError(message: String)
}

enum EmailLinkStatus
{
    case none
    case pending
}

@MainActor
class AuthenticationViewModel: ObservableObject
{
    @AppStorage("email-link") var emailLink: String?
    @Injected(\.authenticationService)
    var authenticationService
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var flow: AuthenticationFlow = .signUp
    @Published var isOtherAuthOptionsVisible = false
    
    @Published var isValid = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var displayName = ""
    
    @Published var isGuestUser = false
    @Published var isVerified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init()
    {
        $email
            .map { email in
                !email.isEmpty
            }
            .assign(to: &$isValid)
        
        $user
            .compactMap { user in
                user?.isAnonymous
            }
            .assign(to: &$isGuestUser)
        
        $user
            .compactMap { user in
                user?.isEmailVerified
            }
            .assign(to: &$isVerified)
        
        $user
            .compactMap { user in
                user?.displayName ?? user?.email ?? ""
            }
            .assign(to: &$displayName)
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    func registerAuthStateHandler()
    {
        if authStateHandler == nil
        {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
    
    func switchFlow()
    {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
    }
    
    func reset()
    {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
    
    // MARK: - Account Deletion
    func deleteAccount() async -> Bool
    {
        return await authenticationService.deleteAccount()
    }
    
    // MARK: - Signing out
    func signOut()
    {
        authenticationService.signOut()
    }
}

// MARK: - Sign in with Apple
extension AuthenticationViewModel
{
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest)
    {
        authenticationService.handleSignInWithAppleRequest(request)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) async -> Bool
    {
        return await authenticationService.handleSignInWithAppleCompletion(withAccountLinking: true, result)
    }
}

// MARK: - Sign in with Google
extension AuthenticationViewModel
{
    func signInWithGoogle() async -> Bool
    {
        guard let clientID = FirebaseApp.app()?.options.clientID
        else
        {
            fatalError("No client ID found in Firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController
        else
        {
            print("There is no root view controller!")
            return false
        }
        
        do
        {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            let user = userAuthentication.user
            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
        }
        catch
        {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            return false
        }
    }
}

extension AuthenticationViewModel
{
    func sendSignInLink() async
    {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.url = URL(string: "https://favourites.page.link/email-link-login")
        
        do
        {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            emailLink = email
        }
        catch
        {
            print(error.localizedDescription)
            errorMessage = error.localizedDescription
        }
    }
    
    var emailLinkStatus: EmailLinkStatus
    {
        emailLink == nil ? .none : .pending
    }
    
    func handleSignInLink(_ url: URL) async
    {
        guard let email = emailLink
        else
        {
            errorMessage = "Invalid email address. Most likely, the link you used has expired. Try signing in again."
            return
        }
        
        let link = url.absoluteString
        
        if Auth.auth().isSignIn(withEmailLink: link)
        {
            do
            {
                let result = try await Auth.auth().signIn(withEmail: email, link: link)
                let user = result.user
                print("User \(user.uid) signed in with email \(user.email ?? "(unknown)"). The email is \(user.isEmailVerified ? "" : "NOT") verified")
                emailLink = nil
            }
            catch
            {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
