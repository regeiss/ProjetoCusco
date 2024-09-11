//
//  PrimaryButtonStyle.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 01/09/24.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle
{
    func makeBody(configuration: Configuration) -> some View
    {
        configuration.label
            .font(.system(.callout, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(.blue)
            .cornerRadius(8)
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle
{
    static var primary: PrimaryButtonStyle
    {
        PrimaryButtonStyle()
    }
}
