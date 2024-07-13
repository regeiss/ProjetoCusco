//
//  AbrigoRepository+Injection.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 12/07/24.
//

import Foundation
import Factory

extension Container
{
    public var abrigoRepository: Factory<AbrigoRepository>
    {
        Factory(self)
        {
            AbrigoRepository()
        }
        .singleton
    }
}
