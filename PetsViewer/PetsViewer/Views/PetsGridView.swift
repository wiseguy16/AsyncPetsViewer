//
//  PetsGridView.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

let imageCache = NSCache<AnyObject, AnyObject>()

struct PetsGridView: View {
  @EnvironmentObject var petEnv: PetViewModel
  @State var selected: Item?
  private let columns = [GridItem(.adaptive(minimum: 150, maximum: 350))]
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: columns) {
        ForEach(petEnv.petItems) { item in
          PetView(item: item)
            .onTapGesture {
              petEnv.path.append(item)
            }
        }
      }
      .padding()
      .navigationDestination(for: Item.self) { item in
        DetailPetView(item: item)
      }
    }
    .onChange(of: petEnv.route, perform: { _ in
      petEnv.hasFetchedOnce.toggle()
      petEnv.fetchPets()
    })
    .onAppear {
      petEnv.fetchPets()
    }
  }
  
  
}



struct PuppyGridView_Previews: PreviewProvider {
  static var previews: some View {
    PetsGridView()
  }
}
