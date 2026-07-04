//
//  OnboardingPage.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingPage: Identifiable {
  let id: Int
  let titleParts: [OnboardingTitlePart]
  let description: String

  var fullTitle: String {
    self.titleParts.map(\.text).joined()
  }
}

struct OnboardingTitlePart: Identifiable {
  let id = UUID()
  let text: String
  let color: Color
}
