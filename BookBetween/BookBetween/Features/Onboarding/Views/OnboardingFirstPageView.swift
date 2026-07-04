//
//  OnboardingFirstPageView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingFirstPageView: View {
  let page: OnboardingPage

  var body: some View {
    ZStack {
      Color.white
        .ignoresSafeArea()

      self.backgroundGradient

      VStack(spacing: 0) {
        Spacer()
          .frame(height: 90)

        OnboardingTitleSection(page: self.page)
          .padding(.bottom, 41)

        Image("onboarding1")
          .resizable()
          .scaledToFit()
          .frame(width: 297, height: 363)

        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var backgroundGradient: some View {
    Circle()
      .fill(
        EllipticalGradient(
          stops: [
            .init(color: Color(red: 0.87, green: 0.92, blue: 0.99), location: 0.30),
            .init(color: Color.white.opacity(0), location: 1)
          ],
          center: .center
        )
      )
      .frame(width: 660, height: 660)
      .offset(x: -194, y: -4)
      .ignoresSafeArea()
  }
}

#Preview {
  OnboardingFirstPageView(
    page: OnboardingPage(
      id: 0,
      titleParts: [
        OnboardingTitlePart(text: "익명으로 ", color: Color.gray800),
        OnboardingTitlePart(text: "만나는 ", color: Color.gray700),
        OnboardingTitlePart(text: "독서모임", color: Color.gray800)
      ],
      description: "관계에 지치지 않게,\n한 권의 책으로만 연결되는 대화"
    )
  )
}
