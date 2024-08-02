//
//  AbrigoRepository.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/07/24.
//

import Foundation
import Factory
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

public class AbrigoRepository: ObservableObject
{
    @Injected(\.firestore) var firestore
    @Injected(\.authenticationService) var authenticationService
    @Published var abrigo = [Abrigo]()
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
            let query = Firestore.firestore().collection(Abrigo.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents
                    else
                    {
                        print("No documents")
                        return
                    }
                    
                    print("Mapping \(documents.count) documents")
                    self?.abrigo = documents.compactMap { queryDocumentSnapshot in
                        do
                        {
                            return try queryDocumentSnapshot.data(as: Abrigo.self)
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

    func addAbrigo(_ abrigo: Abrigo) throws
    {
        try firestore
            .collection(Abrigo.collectionName)
            .addDocument(from: abrigo)
    }

    func update(_ abrigo: Abrigo) throws
        {
            guard let documentId = abrigo.id
            else
            {
                fatalError("Abrigo \(abrigo.nome) has no document ID.")
            }

            try firestore
                .collection(Abrigo.collectionName)
                .document(documentId)
                .setData(from: abrigo, merge: true)
        }

        func delete(_ abrigo: Abrigo)
        {
            guard let documentId = abrigo.id
            else
            {
                fatalError("Abrigo \(abrigo.nome) has no document ID.")
            }

            firestore
                .collection(Abrigo.collectionName)
                .document(documentId)
                .delete()
        }
}
