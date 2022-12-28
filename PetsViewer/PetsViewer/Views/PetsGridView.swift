//
//  PetsGridView.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

let imageCache = NSCache<AnyObject, AnyObject>()
//class Cacher: ObservableObject {
//  @Published var imageCache = NSCache<AnyObject, AnyObject>()
//
//}
struct PetsGridView: View {
  @EnvironmentObject var puppyEnv: PetViewModel
  @State var selected: Item?
 // private let cacher = Cacher()
  private let columns = [GridItem(.adaptive(minimum: 150, maximum: 350))]
  
  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: columns) {
        ForEach(puppyEnv.puppyitems) { item in
          PetView(item: item)
            .onTapGesture {
              puppyEnv.path.append(item)
            }
        }
      }
      .padding()
      .navigationDestination(for: Item.self) { item in
        DetailPetView(item: item)
      }
    }
    .onAppear {
      puppyEnv.fetchPuppies()
    }
  }
  
  
}



struct PuppyGridView_Previews: PreviewProvider {
  static var previews: some View {
    PetsGridView()
  }
}
