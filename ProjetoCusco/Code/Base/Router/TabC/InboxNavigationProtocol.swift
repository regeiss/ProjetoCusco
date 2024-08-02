//
//  InboxNavigationProtocol.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 20/06/24.
//

import Foundation

protocol InboxNavigationProtocol: BaseRouter, Observable
{
    func navigate(to destination: InboxDestination)
}

enum InboxDestination: String, RouterDestination 
{
    case chat
    
    var title: String 
    {
        rawValue.capitalized
    }
}
