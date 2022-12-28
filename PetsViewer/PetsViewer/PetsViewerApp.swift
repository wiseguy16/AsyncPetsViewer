//
//  PetsViewerApp.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/28/22.
//

import SwiftUI

@main
struct PetsViewerApp: App {
    var body: some Scene {
        WindowGroup {
          MainPetsContainer().environmentObject(PetViewModel(apiService: PetService()))
        }
    }
}
