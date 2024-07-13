//
//  AbrigoRepository.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/07/24.
//

import Foundation
import Factory
import FirebaseFirestore
import FirebaseFirestoreSwift

public class AbrigoRepository: ObservableObject
{
    @Injected(\.firestore) var firestore
    @Published var abrigo = [Abrigo]()
    private var listenerRegistration: ListenerRegistration?

    init()
    {
        subscribe()
    }

    deinit
    {
        unsubscribe()
    }

    func subscribe()
    {
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
