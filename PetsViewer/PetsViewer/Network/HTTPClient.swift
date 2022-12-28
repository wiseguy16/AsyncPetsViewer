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
}

extension HTTPClient {
  // MARK: - sendRequest (default)
  func sendRequest<T: Decodable>(for url: URL, responseModel: T.Type) async throws -> T {
    
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
  
}

