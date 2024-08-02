//
//  RouterDestination.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/06/24.
//

import Foundation

protocol RouterDestination: Hashable, Identifiable, Equatable, Codable, CustomStringConvertible 
{
    var id: String { get }
    var description: String { get }
}

extension RouterDestination 
{
    var id: String 
    {
        return description
    }
}

extension RouterDestination where Self: RawRepresentable, RawValue == String 
{
    var description: String 
    {
        return rawValue
    }
}

extension RouterDestination 
{
    static func == (lhs: any RouterDestination, rhs: any RouterDestination) -> Bool
    {
        return lhs.id == rhs.id
    }
}
