//
//  Endpoint.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import Foundation

// MARK: - Endpoint

struct Endpoint {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [String: String]?
}

public enum Route: String, CaseIterable {
  case puppy
  case cats
  case hampster
}

// MARK: - RequestError

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

