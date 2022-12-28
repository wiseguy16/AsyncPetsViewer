//
//  MainPetsContainer.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

struct MainPetsContainer: View {  
  @EnvironmentObject var petEnv: PetViewModel
  
  var body: some View {
    NavigationStack(path: $petEnv.path) {
      VStack {
        PetsGridView()
      }
      .navigationTitle("PetsViewer")
    }
  }
  
}
