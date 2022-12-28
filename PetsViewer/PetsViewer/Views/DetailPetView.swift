//
//  DetailPetView.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

struct DetailPetView: View {
  let item: Item
  private var share: URL {
    return URL(string: item.media.m) ?? URL(string: "https://www.apple.com")!
  }
  @State private var showingOptions = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text(item.title)
        .fontly(size: 16, weight: .semibold, edges: .bottom)
      ImageLoadView(urlString: item.media.m)
      Text(item.hashTags)
        .fontly(size: 13, weight: .thin, edges: .top, length: 4)
      Text(item.author)
        .fontly(size: 13, weight: .heavy, edges: [.top, .bottom], length: 8)
      Text(item.readableDate).fontly(size: 12, weight: .regular)
      Spacer()
    }
    .padding()
    .navigationBarTitle("Pet Details")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar(content: {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(
          action: {
            showingOptions.toggle()
          },
          label: {
            Image(systemName: "heart.fill")
              .foregroundColor(.red)
          })
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        ShareLink(item: share)
      }
    })
    .alert("This pet has been saved to favorites", isPresented: $showingOptions, actions: {})
  }
  
}

struct DetailPuppyView_Previews: PreviewProvider {
  static var previews: some View {
    DetailPetView(item: Item.mock)
  }
}
