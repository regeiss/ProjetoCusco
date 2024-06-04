//
//  ProjetoCuscoApp.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate 
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        FirebaseApp.configure()
        return true
    }
}


@main
struct ProjetoCuscoApp: App 
{
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene
    {
        WindowGroup 
        {
            ContentView()
        }
    }
}
