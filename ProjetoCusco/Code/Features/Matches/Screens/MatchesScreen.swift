//
//  MatchesScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/08/24.
//

import SwiftUI
import SwiftfulRouting

struct MatchesScreen: View
{
    @Environment(\.router) var router
    @StateObject private var viewModel = TagViewModel()
    
    var body: some View
    {
        MatchFlowLayoutScreen(alignment: .leading)
        {
            ForEach($viewModel.tag) { tag in
                Button(action: {
                    $viewModel.$tag
                }, label: {
                    Text("tag.nome")
                })
            }
        }
    }
}
