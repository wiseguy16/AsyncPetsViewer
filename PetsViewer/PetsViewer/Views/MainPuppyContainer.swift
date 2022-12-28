//
//  MainPuppyContainer.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

struct MainPuppyContainer: View {  
  @EnvironmentObject var puppyEnv: PuppyViewModel
  
  var body: some View {
    NavigationStack(path: $puppyEnv.path) {
      VStack {
        PuppyGridView()
      }
      .navigationTitle("PetsViewer")
    }
  }
  
}
