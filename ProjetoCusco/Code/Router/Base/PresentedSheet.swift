//
//  PresentedSheet.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 19/06/24.
//

import Foundation
enum PresentedSheet: Identifiable 
{
    case viewOne
    case transportation(type: TransportationView.TransportationType)

    var id: String 
    {
        return switch self 
        {
        case .viewOne:
            "View one"
        case .transportation:
            "Transportation"
        }
    }
}
