//
//  Image+ext.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/16/22.
//

import SwiftUI

extension Image: Identifiable {
  public var id: UUID {
    return UUID()
  }
}
