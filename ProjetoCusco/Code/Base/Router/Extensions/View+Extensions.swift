//
//  View+Extensions.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 06/06/24.
//

import Foundation
import SwiftUI

extension View 
{
    func navigationBackButton(title: String? = nil, action: @escaping () -> Void) -> some View 
    {
        navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: action, label: {
                        HStack(spacing: 0) {
                            Image(systemName: "chevron.backward")
                                .fontWeight(.semibold)

                            if let title {
                                Text(title)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }

                    })
                    .frame(minWidth: .navigationBarHeight)
                    .offset(x: .navigationBackButtonXOffset)
                }
            }
    }

    func routerDestination<D, C>(router: BaseRouter, navigationBackTitle: String? = nil,
                                 @ViewBuilder destination: @escaping (D) -> C) -> some View where D : Hashable, C : View 
    {
        navigationDestination(for: D.self) { item in
            destination(item)
                .navigationBackButton(title: navigationBackTitle, action: router.navigateBack)
        }
    }
}
