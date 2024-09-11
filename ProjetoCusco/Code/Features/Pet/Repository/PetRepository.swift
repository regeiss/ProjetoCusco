//
//  PetRepository.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import Foundation
import Factory
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

public class PetRepository: ObservableObject
{
    @Injected(\.firestore) var firestore
    @Injected(\.authenticationService) var authenticationService
    @Published var pet = [Pet]()
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
            let query = Firestore.firestore().collection(Pet.collectionName)
            
            listenerRegistration = query
                .addSnapshotListener { [weak self] (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents
                    else
                    {
                        print("No documents")
                        return
                    }
                    
                    print("Mapping \(documents.count) documents")
                    self?.pet = documents.compactMap { queryDocumentSnapshot in
                        do
                        {
                            return try queryDocumentSnapshot.data(as: Pet.self)
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

    func addPet(_ pet: Pet) throws
    {
        try firestore
            .collection(Pet.collectionName)
            .addDocument(from: pet)
    }

    func update(_ pet: Pet) throws
        {
            guard let documentId = pet.id
            else
            {
                fatalError("Pet \(pet.nome) has no document ID.")
            }

            try firestore
                .collection(Pet.collectionName)
                .document(documentId)
                .setData(from: pet, merge: true)
        }

        func delete(_ pet: Pet)
        {
            guard let documentId = pet.id
            else
            {
                fatalError("Pet \(pet.nome) has no document ID.")
            }

            firestore
                .collection(Pet.collectionName)
                .document(documentId)
                .delete()
        }
}
