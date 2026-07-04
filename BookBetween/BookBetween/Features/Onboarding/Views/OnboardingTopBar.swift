//
//  OnboardingTopBar.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingTopBar: View {
  let backButtonAction: () -> Void
  let skipButtonAction: () -> Void

  var body: some View {
    HStack {
      Button(action: self.backButtonAction) {
        Image(systemName: "chevron.left")
          .frame(width: 12.41261, height: 24)
          .foregroundStyle(Color.gray500)
      }

      Spacer()

      Button(action: self.skipButtonAction) {
        Text("건너뛰기")
          .body2RegularStyle
          .foregroundStyle(Color.gray500)
      }
    }
  }
}

#Preview {
  OnboardingTopBar(
    backButtonAction: {
    },
    skipButtonAction: {
    }
  )
}
