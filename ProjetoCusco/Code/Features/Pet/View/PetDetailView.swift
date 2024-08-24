//
//  PetDetailView.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 23/08/24.
//

import SwiftUI

struct PetDetailView: View
{
    @State var pet: Pet
    
    var body: some View
    {
        Text(pet.nome)
    }
}
