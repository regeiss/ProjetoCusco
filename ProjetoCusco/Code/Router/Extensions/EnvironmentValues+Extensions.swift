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

extension EnvironmentValues
{
    var currentTab: Binding<ContentView.Tab> 
    {
        get { self[CurrentTabKey.self] }
        set { self[CurrentTabKey.self] = newValue }
    }
}
