//
//  PetImage.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 02/10/24.
//

import SwiftUI
import PhotosUI

struct PetImage: View
{
    let imageState: PhotoPickerModel.ImageState
    
    var body: some View
    {
        switch imageState
        {
            case .success(let image):
                image.resizable()
            case .loading:
                ProgressView()
            case .empty:
                Image(systemName: "dog")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
        }
    }
}

struct CircularPetImage: View
{
    let imageState: PhotoPickerModel.ImageState
    
    var body: some View
    {
        PetImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 300, height: 300)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct EditableCircularPetImage: View
{
    @ObservedObject var viewModel: PhotoPickerModel
    
    var body: some View
    {
        CircularPetImage(imageState: viewModel.imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
