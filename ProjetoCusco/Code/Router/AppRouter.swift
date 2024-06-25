//
//  AppRouter.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 05/06/24.
//

import Foundation
import SwiftUI

@Observable class AppRouter
{
    var selectedTab: ContentView.Tab = .taba
    var presentedSheet: PresentedSheet?

    // MARK: - Routers
    var tabARouter = TabARouter()
    var tabBRouter = TabBRouter()
    var tabCRouter = TabCRouter()
    var tabDRouter = TabDRouter()
}

