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

extension Pet
{
  static let samples = [
    Pet(id: "1", nome: "Cusco 1", ativo: true),
    Pet(id: "2", nome: "Cusc0 2"),
    Pet(id: "3", nome: "Cusco 3"),
    Pet(id: "4", nome: "Cusco 4")
  ]
}
