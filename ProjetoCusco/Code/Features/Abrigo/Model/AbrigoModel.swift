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
    var userId: String?
}

extension Abrigo
{
    static let collectionName = "abrigo"
}

extension Abrigo 
{
  static let samples = [
    Abrigo(id: "1", nome: "********", ativo: true),
    Abrigo(id: "2", nome: "************", ativo: false),
    Abrigo(id: "3", nome: "**", ativo: true),
    Abrigo(id: "4", nome: "********************", ativo: true)
  ]
}
