//
//  AbrigoModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/07/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct Abrigo: Identifiable, Codable
{
    @DocumentID var id: String?
    var nome: String
    var ativo: Bool = true
}

extension Abrigo
{
    static let collectionName = "abrigo"
}

extension Abrigo 
{
  static let samples = [
    Abrigo(id: "1", nome: "Build sample app", ativo: true),
    Abrigo(id: "2", nome: "Create tutorial"),
    Abrigo(id: "3", nome: "???"),
    Abrigo(id: "4", nome: "PROFIT!")
  ]
}
