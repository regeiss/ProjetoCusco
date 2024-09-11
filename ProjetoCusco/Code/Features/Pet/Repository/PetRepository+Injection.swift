//
//  PetRepository+Injection.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import Foundation
import Factory

extension Container
{
    public var petRepository: Factory<PetRepository>
    {
        Factory(self)
        {
            PetRepository()
        }
        .singleton
    }
}
