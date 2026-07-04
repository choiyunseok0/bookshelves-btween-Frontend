//
//  OnboardingSecondPageView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingSecondPageView: View {
  let page: OnboardingPage

  var body: some View {
    ZStack {
      Color.white
        .ignoresSafeArea()

      VStack(spacing: 0) {
        Spacer()
          .frame(height: 90)

        OnboardingTitleSection(page: self.page)

        Spacer()
      }
    }
  }
}

#Preview {
  OnboardingSecondPageView(
    page: OnboardingPage(
      id: 1,
      titleParts: [
        OnboardingTitlePart(text: "AI와 함께하는 ", color: Color.gray900),
        OnboardingTitlePart(text: "깊이있는 독서", color: Color.green800)
      ],
      description: "질문, 요약, 인사이트까지\n읽고 생각하는 시간을 함께해요."
    )
  )
}
