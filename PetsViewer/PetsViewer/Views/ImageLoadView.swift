//
//  ImageLoadView.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

// MARK: - ImageLoadView

/// Note: There seems to be some performance issues
/// with Apple's latest `AsyncImage` when used in
/// a lazy stack. I would love to dig deeper into
/// how this could be cached to render quicker.
///

struct ImageLoadView: View {
  let urlString: String
    var body: some View {
      AsyncImage(url: URL(string: urlString)) { phase in
        switch phase {
        case .empty:
          ProgressView()
            .frame(width: 50, height: 50)
            .padding()
        case .success(let returnedImage):
          returnedImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(4)
        case .failure:
          Image(systemName: "questionmark").resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .padding()
        default:
          Image(systemName: "questionmark").resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
            .padding()
        }
      }
    }
}

struct ImageLoadView2: View {
  let urlString: String
  @State var uiImage: UIImage?
  var body: some View {
    VStack {
      if let image = uiImage {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(4)
      } else {
        ProgressView()
          .frame(width: 50, height: 50)
          .padding()
      }
    }
    .task {
      do {
        let image = try await getImageFor(url: urlString)
        await MainActor.run {
          self.uiImage = image
        }
      } catch {
        print("failed to load")
      }
    }
  }
  
  func getImageFor(url: String) async throws -> UIImage {
    guard let url = URL(string: url) else { throw RequestError.decode }
    // retrieves image if already available in cache
    if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
      return imageFromCache
    }
    let (data, _) = try await URLSession.shared.data(from: url)
    if let imageToCache = UIImage(data: data) {
      imageCache.setObject(imageToCache, forKey: url as AnyObject)
      return imageToCache
    } else {
      throw RequestError.decode
    }
  }
}
