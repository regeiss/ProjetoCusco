//
//  HomeModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 20/08/24.
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
}

extension Pet
{
    static let collectionName = "pets"
}

extension Pet
{
  static let samples = [
    Pet(id: "1", nome: "Build sample app", ativo: true),
    Pet(id: "2", nome: "Create tutorial"),
    Pet(id: "3", nome: "???"),
    Pet(id: "4", nome: "PROFIT!")
  ]
}
