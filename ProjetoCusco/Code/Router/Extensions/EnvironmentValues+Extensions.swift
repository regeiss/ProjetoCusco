//
//  EnvironmentValues+Extensions.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 05/06/24.
//

import SwiftUI

struct CurrentTabKey: EnvironmentKey 
{
    static var defaultValue: Binding<ContentView.Tab> = .constant(.taba)
}

struct PresentedSheetKey: EnvironmentKey 
{
    static var defaultValue: Binding<PresentedSheet?> = .constant(nil)
}

struct InboxRouterRouterKey: EnvironmentKey
{
    static let defaultValue: any InboxNavigationProtocol = TabCRouter()
}

extension EnvironmentValues 
{
    var currentTab: Binding<ContentView.Tab> 
    {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }

    var inboxRouter: any InboxNavigationProtocol
    {
        get { self[InboxRouterRouterKey.self] }
        set { self[InboxRouterRouterKey.self] = newValue }
    }

    var presentedSheet: Binding<PresentedSheet?> 
    {
        get { self[PresentedSheetKey.self] }
        set { self[PresentedSheetKey.self] = newValue }
    }
}
