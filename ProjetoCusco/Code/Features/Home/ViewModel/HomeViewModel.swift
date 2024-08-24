//
//  HomeViewModel.swift
//  ProjetoCusco
//
//  Created by Roberto Edgar Geiss on 22/08/24.
//

import Foundation
import SwiftfulRouting

// This is the same as SampleViewModel, except data flows through a delegate to decouple ViewModel from DataService

@MainActor
final class BasicViewModel: ObservableObject {

    private let router: AnyRouter

//    @Published private(set) var title: String? = nil
//    @Published private(set) var subtitle: String? = nil
        
    init(router: AnyRouter) {
        self.router = router
    }
    
    private func goToNextScreen(title: String) {
//        router.showScreen(.push) { router in
//            MyNextView(title: title)
//        }
    }
}

