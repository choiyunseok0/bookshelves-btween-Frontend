//
//  OnboardingThirdPageView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingThirdPageView: View {
  let page: OnboardingPage

  var body: some View {
    ZStack {
      Color.white
        .ignoresSafeArea()

      VStack(spacing: 0) {
        Spacer()
          .frame(height: 230)

        OnboardingTitleSection(page: self.page)

        Spacer()
      }
    }
  }
}

#Preview {
  OnboardingThirdPageView(
    page: OnboardingPage(
      id: 2,
      titleParts: [
        OnboardingTitlePart(text: "나만의 서재", color: Color.gray900)
      ],
      description: "읽은 책들을 기록하고,\n언제든 다시 꺼내볼 수 있게"
    )
  )
}
