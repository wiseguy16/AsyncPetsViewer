//
//  HTTPClient.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import Foundation

// MARK: - HTTPClient
protocol HTTPClient {
  func sendRequest<T: Decodable>(for url: URL, responseModel: T.Type) async throws -> T
  func makeUrlSource(for route: Route) -> URL?
 // var source: Source { get set }
}

extension HTTPClient {
  // MARK: - sendRequest (default)
  func sendRequest<T: Decodable>(for url: URL, responseModel: T.Type) async throws -> T {
//    var urlSource: URL?
//    
//    switch source {
//    case .endpoint(let type):
//      urlSource = makeUrlFrom(endpointType: type)
//    case .url(let url):
//      urlSource = url
//    }
    
    
//    guard let url = urlSource else {
//      throw RequestError.invalidURL
//    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
  
    guard let response = response as? HTTPURLResponse else {
      throw RequestError.noResponse
    }
    switch response.statusCode {
    case 200...299:
      guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
        throw RequestError.decode
      }
      return decodedResponse
    case 401:
      throw RequestError.unauthorized
    default:
      throw RequestError.unexpectedStatusCode
    }
    
  }
  
//  // MARK: - Helper methods
//  private func makeUrlFrom(endpointType: EndpointType) -> URL? {
//    guard let endpoint = makeEndpointWithType(endpointType) else { return nil }
//    var urlComponents = URLComponents()
//    urlComponents.scheme = endpoint.scheme
//    urlComponents.host = endpoint.host
//    urlComponents.path = endpoint.path
//    if let queries = endpoint.queryItems {
//      urlComponents.queryItems = queries.map { (key, value) -> URLQueryItem in
//        URLQueryItem(name: key, value: String(value))
//      }
//    }
//    return urlComponents.url
//  }
  
}

