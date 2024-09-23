//
//  TagModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseCore

struct Tag: Identifiable, Codable
{
    @DocumentID var id: String?
    var nome: String
}

extension Tag
{
    static let collectionName = "tag"
}
