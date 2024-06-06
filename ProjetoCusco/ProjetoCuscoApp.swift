//
//  ProjetoCuscoApp.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

@main
struct ProjetoCuscoApp: App 
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Bindable private var appRouter = AppRouter()

    var body: some Scene
    {
        WindowGroup 
        {
            ContentView()
                .environment(appRouter)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        FirebaseApp.configure()

        let useEmulator = UserDefaults.standard.bool(forKey: "useEmulator")
        if useEmulator
        {
          let settings = Firestore.firestore().settings
          settings.host = "localhost:8080"
          settings.isSSLEnabled = false
          Firestore.firestore().settings = settings

          Auth.auth().useEmulator(withHost: "localhost", port: 9099)
        }
        return true
    }
}
