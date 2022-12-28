//
//  Font+ext.swift
//  PetsViewer
//
//  Created by Gregory Weiss on 12/17/22.
//

import SwiftUI

// MARK: - FontModifier
public struct FontModifier: ViewModifier {
  public var size: CGFloat
  public var weight: Font.Weight?
  public var design: Font.Design?
  public var color: Color
  public var edges: Edge.Set
  public var length: CGFloat?
  public func body(content: Content) -> some View {
      content
      .font(.system(size: size, weight: weight, design: design))
      .foregroundColor(color)
      .padding(edges, length)
  }
}

extension View {
  // MARK: - fontly
  public func fontly(size: CGFloat = 12, weight: Font.Weight? = nil, design: Font.Design? = nil,  color: Color = .black, edges: Edge.Set = [], length: CGFloat? = nil) -> some View {
    return modifier(FontModifier(size: size, weight: weight, design: design, color: color, edges: edges, length: length))
  }
}
