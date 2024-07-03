//
//  AppState.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/07/24.
//

import Foundation

class AppState
{
    var ultimaKM: Int32

    static var shared = AppState()

    private init()
    {
        ultimaKM = 1
    }
}
