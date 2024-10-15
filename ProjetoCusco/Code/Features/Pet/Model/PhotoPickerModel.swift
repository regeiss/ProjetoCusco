//
//  PhotoPickerModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/10/24.
//

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class PhotoPickerModel: ObservableObject
{
    // MARK: - Image
    
    enum ImageState
    {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error
    {
        case importFailed
    }
    
    struct PhotoPickerImage: Transferable
    {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation
        {
            DataRepresentation(importedContentType: .image) { data in
            #if canImport(AppKit)
                guard let nsImage = NSImage(data: data)
                else
                {
                    throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
                return ProfileImage(image: image)
            #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data)
                else
                {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return PhotoPickerImage(image: image)
            #else
                throw TransferError.importFailed
            #endif
            }
        }
    }
    
    @Published private(set) var imageState: ImageState = .empty
    @Published var imageSelection: PhotosPickerItem?
    {
        didSet
        {
            if let imageSelection
            {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            }
            else
            {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress
    {
        return imageSelection.loadTransferable(type: PhotoPickerImage.self)
        { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection
                else
                {
                    print("Failed to get the selected item.")
                    return
                }
                
                switch result
                {
                    case .success(let profileImage?):
                        self.imageState = .success(profileImage.image)
                    case .success(nil):
                        self.imageState = .empty
                    case .failure(let error):
                        self.imageState = .failure(error)
                }
            }
        }
    }
}
