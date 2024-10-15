//
//  CustomSegmentedControl.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 10/10/24.
//

import SwiftUI

struct CustomSegmentedControl: View
{
    @Binding var preselectedIndex: Int
    var options: [String]
    
    var body: some View
    {
        HStack(spacing: 0)
        {
            ForEach(options.indices, id:\.self) { index in
                ZStack
                {
                    Rectangle()
                        .fill(.blue.opacity(0.2))
                    
                    Rectangle()
                        .fill(.blue)
                        .cornerRadius(20)
                        .padding(2)
                        .opacity(preselectedIndex == index ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                preselectedIndex = index
                            }
                        }
                }
                .overlay(
                    Text(options[index])
                )
            }
        }
        .frame(height: 50)
        .cornerRadius(20)
    }
}
