//
//  TagRepository+Injection.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/09/24.
//

import Foundation
import Factory

extension Container
{
    public var tagRepository: Factory<TagRepository>
    {
        Factory(self)
        {
            TagRepository()
        }
        .singleton
    }
}

