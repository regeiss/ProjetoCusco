//
//  TagRepository.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import Foundation
import Factory
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

public class TagRepository: ObservableObject
{
    @Injected(\.firestore) var firestore
    @Injected(\.authenticationService) var authenticationService
    @Published var tag = [Tag]()
    @Published var user: User?
    
    private var listenerRegistration: ListenerRegistration?
    private var cancelables = Set<AnyCancellable>()
    
    init()
    {
        authenticationService.$user
            .assign(to: &$user)
        
        $user.sink { user in
            self.unsubscribe()
            self.subscribe(user: user)
        }
        .store(in: &cancelables)
    }
    
    deinit
    {
        unsubscribe()
    }
    
    func subscribe(user: User? = nil)
    {
        if listenerRegistration == nil {
            let query = Firestore.firestore().collection(Tag.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents
                    else
                    {
                        print("No documents")
                        return
                    }
                    
                    print("Mapping \(documents.count) documents")
                    self?.tag = documents.compactMap { queryDocumentSnapshot in
                        do
                        {
                            return try queryDocumentSnapshot.data(as: Tag.self)
                        }
                        catch
                        {
                            print("Error while trying to map document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                            return nil
                        }
                    }
                }
        }
    }
    
    private func unsubscribe()
    {
        if listenerRegistration != nil
        {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
    
    func addTag(_ tag: Tag) throws
    {
        try firestore
            .collection(Tag.collectionName)
            .addDocument(from: tag)
    }
    
    func update(_ tag: Tag) throws
    {
        guard let documentId = tag.id
        else
        {
            fatalError("Tag \(tag.nome) has no document ID.")
        }
        
        try firestore
            .collection(Tag.collectionName)
            .document(documentId)
            .setData(from: tag, merge: true)
    }
    
    func delete(_ tag: Tag)
    {
        guard let documentId = tag.id
        else
        {
            fatalError("Tag \(tag.nome) has no document ID.")
        }
        
        firestore
            .collection(Tag.collectionName)
            .document(documentId)
            .delete()
    }
}
