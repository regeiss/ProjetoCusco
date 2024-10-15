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
       // RouterView { _ in
            MatchFlowLayoutScreen(alignment: .leading)
            {
                ForEach(viewModel.tag) { tag in
                    Button(action: {
                        viewModel.selectTag(tag)
                    }, label: {
                        Text("# " + (tag.nome))
                    }).buttonStyle(.borderedProminent)
                }
            }.navigationTitle("Tags")
        //}
    }
}
