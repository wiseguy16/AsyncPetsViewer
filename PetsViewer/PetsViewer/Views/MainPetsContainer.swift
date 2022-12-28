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
        Picker("", selection: $petEnv.route) {
          ForEach(Route.allCases, id: \.self) { route in
            Text(route.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        PetsGridView()
      }
      .navigationTitle("PetsViewer")
    }
  }
  
}
