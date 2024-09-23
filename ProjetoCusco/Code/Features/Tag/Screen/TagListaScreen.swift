//
//  TagListaScreen.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import SwiftUI
import SwiftfulRouting

struct TagListaScreen: View
{
    @Environment(\.router) var router
    @StateObject private var viewModel = TagViewModel()
    @State var editableTag: Tag?
    @State var isAddDialogPresented = false

    var body: some View
    {
        RouterView { _ in
            
            List($viewModel.tag) { $tag in
                TagDetalheView(tag: $tag)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true)
                {
                    Button(role: .destructive, action: { viewModel.delete(tag)})
                    {
                        Image(systemName: "trash")
                    }
                }
                .onTapGesture
                {
                    editableTag = tag
                }
            }
            .navigationTitle("Tag")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing)
                {
                    Button(action: presentAddView)
                    {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddDialogPresented)
            {
                TagAddEditView { tag in
                    viewModel.addTag(tag)
                }
            }
            .sheet(item: $editableTag) { tag in
                TagAddEditView(tag: tag, mode: .edit) { tag in
                    viewModel.update(tag)
                }
            }
            .tint(.blue)
        }
    }

    private func presentAddView()
    {
        isAddDialogPresented.toggle()
    }
}
