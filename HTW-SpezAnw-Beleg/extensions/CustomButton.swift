//
//  CustomButton.swift
//  HTW-SpezAnw-Beleg
//
//  Created by Constantin Schulte-Kersmecke on 30.11.21.
//

import Foundation
import SwiftUI

struct CustomButtonModifier: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled
    
    func body(content: Content) -> some View {
    content
      .font(.title)
      .foregroundColor(.white)
      .padding()
      .frame(width: 50)
      .background(isEnabled ? .blue : .gray)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    
  }
}

extension View {
  func customButton() -> some View {
    modifier(CustomButtonModifier())
  }
}
