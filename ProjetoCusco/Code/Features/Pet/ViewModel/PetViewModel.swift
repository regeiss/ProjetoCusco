//
//  PetViewModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import Foundation
import Combine
import Factory
import UIKit
import Firebase
import FirebaseStorage

class PetViewModel: ObservableObject
{
    @Published var pet = [Pet]()
    @Published var errorMessage: String?

    private var petRepository: PetRepository =  PetRepository()

    init()
    {
        petRepository.$pet.assign(to: &$pet)
    }

    func addPet(_ pet: Pet)
    {
        do
        {
            try petRepository.addPet(pet)
            errorMessage = nil
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func update(_ pet: Pet)
    {
        do
        {
            try petRepository.update(pet)
        }
        catch
        {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func delete(_ pet: Pet)
    {
        petRepository.delete(pet)
    }
    //  func toggleCompleted(_ reminder: Pet) {
    //    if let index = pets.firstIndex(where: { $0.id == reminder.id} ) {
    //      pets[index].isCompleted.toggle()
    //    }
    //  }
    
//    func saveImage(pet: Pet, photo: Photo, image: UIImage) async -> Bool
//    {
//        var imageURLString = photo.imageURLString
//        
//        guard let petId = pet.id
//        else { return false}
//        
//        let photoName = UUID().uuidString
//        let storage = Storage.storage()
//        let storageRef = storage.reference().child("\(petId)/\(photoName).jpeg")
//        
//        guard let resizedImage = image.jpegData(compressionQuality: 0.2)
//        else { return false}
//        
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpg"
//        
//        do
//        {
//            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
//            do
//            {
//                let imageURL = try await storageRef.downloadURL()
//                imageURLString = "\(imageURL)"
//            }
//            catch
//            {
//                return false
//            }
//        }
//        catch
//        {
//            print("Erro carregando imagem no Firestore")
//        }
//        
//        return true
//    }
}
