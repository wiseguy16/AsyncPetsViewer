//
//  PuppyView.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/17/22.
//

import SwiftUI

struct PuppyView: View {

  let item: Item
  
  var body: some View {
    VStack {
      ImageLoadView2(urlString: item.media.m)
      VStack(alignment: .leading) {
        Text(item.title)
          .fontly(size: 14, weight: .semibold)
        Text(item.fourTags)
          .fontly(size: 13, weight: .thin)
        Text(item.readableDate)
          .fontly(size: 12, weight: .medium, color: Color(.lightGray))
      }
      .padding(.horizontal, 4)
      .padding(.bottom, 8)
    }
    .background(.thinMaterial)
  }
  
}
