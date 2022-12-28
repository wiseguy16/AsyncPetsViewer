//
//  PetViewModel.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI
import Combine

class PetViewModel: ObservableObject {
  
  // MARK: - properties
  @Published var path = NavigationPath()
  @Published var puppyitems: [Item] = []
  @Published var hasFetchedOnce = false
  private let apiService: HTTPClient
  
  // MARK: - init
  init(apiService: HTTPClient) {
    self.apiService = apiService
  }
  
  // MARK: - fetchPuppies
  func fetchPuppies() {
    guard !hasFetchedOnce else { return }
    Task {
      do {
        guard let url = apiService.makeUrlSource(for: .puppy) else { return }
        let result = try await apiService.sendRequest(for: url, responseModel: PetResponseModel.self)
        await MainActor.run { [weak self] in
          self?.puppyitems = result.items
          self?.hasFetchedOnce.toggle()
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
  
}


