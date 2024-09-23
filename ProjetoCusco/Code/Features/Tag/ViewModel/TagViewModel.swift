//
//  TagViewModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import Foundation
import Combine
import Firebase
import FirebaseStorage

class TagViewModel: ObservableObject
{
    @Published var tag = [Tag]()
    @Published var errorMessage: String?

    private var tagRepository: TagRepository =  TagRepository()

    init()
    {
        tagRepository.$tag.assign(to: &$tag)
    }

    func addTag(_ tag: Tag)
    {
        do
        {
            try tagRepository.addTag(tag)
            errorMessage = nil
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func update(_ tag: Tag)
    {
        do
        {
            try tagRepository.update(tag)
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func delete(_ tag: Tag)
    {
        tagRepository.delete(tag)
    }
    //  func toggleCompleted(_ reminder: Tag) {
    //    if let index = tags.firstIndex(where: { $0.id == reminder.id} ) {
    //      tags[index].isCompleted.toggle()
    //    }
    //  }
    
}
