//
//  PuppyService.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import Foundation

// MARK: - PuppyService
struct PetService: HTTPClient {
  func makeUrlSource(for route: Route) -> URL? {
    switch route {
    case .puppy:
      return makeUrlFrom(endpoint: PetService.puppyEndpoint)
    case .cats:
      return makeUrlFrom(endpoint: PetService.catsEndpoint)
    }
  }
  
  // MARK: - endpoints
  static private let puppyEndpoint = Endpoint(
    scheme: "https",
    host: "api.flickr.com",
    path: "/services/feeds/photos_public.gne",
    queryItems:
      ["tags": "puppy", "format": "json",
       "nojsoncallback": "1", "lang": "en-us"]
  )
  
  static private let catsEndpoint = Endpoint(
    scheme: "https",
    host: "api.flickr.com",
    path: "/services/feeds/photos_public.gne",
    queryItems:
      ["tags": "cats", "format": "json",
       "nojsoncallback": "1", "lang": "en-us"]
  )
  
  // MARK: - Helper methods
  private func makeUrlFrom(endpoint: Endpoint) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = endpoint.scheme
    urlComponents.host = endpoint.host
    urlComponents.path = endpoint.path
    if let queries = endpoint.queryItems {
      urlComponents.queryItems = queries.map { (key, value) -> URLQueryItem in
        URLQueryItem(name: key, value: String(value))
      }
    }
    return urlComponents.url
  }
  
}
