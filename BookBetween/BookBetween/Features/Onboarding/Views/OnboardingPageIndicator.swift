//
//  OnboardingPageIndicator.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingPageIndicator: View {
  let currentPage: Int
  let totalPage: Int

  var body: some View {
    HStack(spacing: 8) {
      ForEach(0..<self.totalPage, id: \.self) { index in
        Capsule()
          .fill(index == self.currentPage ? Color.green600 : Color.gray200)
          .frame(width: index == self.currentPage ? 32 : 8, height: 8)
      }
    }
  }
}

#Preview {
  OnboardingPageIndicator(currentPage: 0, totalPage: 3)
}
