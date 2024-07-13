//
//  AbrigoViewModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/07/24.
//

import Foundation
import Combine
import Factory

class AbrigoViewModel: ObservableObject
{
    @Published var abrigo = [Abrigo]()
    @Published var errorMessage: String?

    private var abrigoRepository: AbrigoRepository =  AbrigoRepository()

    init()
    {
        abrigoRepository.$abrigo.assign(to: &$abrigo)
    }

    func addAbrigo(_ abrigo: Abrigo)
    {
        do
        {
            try abrigoRepository.addAbrigo(abrigo)
            errorMessage = nil
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func update(_ abrigo: Abrigo)
    {
        do
        {
            try abrigoRepository.update(abrigo)
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func delete(_ abrigo: Abrigo)
    {
        abrigoRepository.delete(abrigo)
    }
    //  func toggleCompleted(_ reminder: Abrigo) {
    //    if let index = abrigos.firstIndex(where: { $0.id == reminder.id} ) {
    //      abrigos[index].isCompleted.toggle()
    //    }
    //  }
}
