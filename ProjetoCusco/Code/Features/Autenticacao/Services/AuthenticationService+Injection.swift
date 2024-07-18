//
//  AuthenticationService+Injection.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 15/07/24.
//

import Foundation
import Factory

extension Container
{
    public var authenticationService: Factory<AuthenticationService>
    {
        self { AuthenticationService() }.singleton
    }
}
