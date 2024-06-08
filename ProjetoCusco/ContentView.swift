//
//  ContentView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/06/24.
//

import SwiftUI

struct ContentView: View
{
    enum Tab
    {
        case taba
        case tabb
        case tacc
        case tabd
    }

    @Environment(AppRouter.self) private var appRouter

    var body: some View
    {
        @Bindable var appRouter = appRouter

        TabView(selection: $appRouter.selectedTab) 
        {
            TabA()
                .tag(Tab.taba)
                .tabItem {
                    Image(systemName: "a.circle")
                }

            TabB()
                .tag(Tab.tabb)
                .tabItem {
                    Image(systemName: "b.circle")
                }

            TabC()
                .tag(Tab.tacc)
                .tabItem {
                    Image(systemName: "c.circle")
                }

            TabD()
                .tag(Tab.tabd)
                .tabItem {
                    Image(systemName: "d.circle")
                }
        }
        .environment(\.currentTab, $appRouter.selectedTab)
    }
}

struct TabA: View
{
    var body: some View
    {
        Text("A")
    }
}

struct TabB: View
{
    var body: some View
    {
        Text("B")
    }
}

struct TabC: View
{
    var body: some View
    {
        Text("C")
    }
}

struct TabD: View
{
    var body: some View
    {
        Text("D")
    }
}

//#Preview
//{
//    ContentView()
//}
