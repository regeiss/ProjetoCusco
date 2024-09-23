//
//  PetModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct Pet: Identifiable, Codable
{
    @DocumentID var id: String?
    var nome: String
    var ativo: Bool = true
    var userId: String?
    var imageURLString: String?
}

extension Pet
{
    static let collectionName = "pet"
}
