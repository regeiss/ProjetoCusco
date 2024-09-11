//
//  PhotoModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Photo: Identifiable, Codable
{
    @DocumentID var id: String?
    var imageURLString: String = ""
    var descricao: String = ""
    var reviewer: String = ""
    var postedOn: Date = Date()
    
    var dictionary: [String: Any]
    {
        return ["imageURLString": imageURLString, "descricao": descricao, "reviewer": reviewer, "postedOn": Timestamp(date: Date())]
    }
}
