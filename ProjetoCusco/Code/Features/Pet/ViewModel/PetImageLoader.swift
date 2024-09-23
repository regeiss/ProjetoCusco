//
//  PetImageLoader.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 11/09/24.
//

import UIKit
import SwiftUI
import Firebase
import FirebaseStorage

public class StorageManager: ObservableObject
{
    let storage = Storage.storage()

    func upload(image: UIImage)
    {
        // Create a storage reference
        let storageRef = storage.reference().child("images/image.jpg")

        // Resize the image to 200px with a custom extension
        let resizedImage = image //.aspectFittedToHeight(200)

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = resizedImage.jpegData(compressionQuality: 0.2)

        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }

                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
}
