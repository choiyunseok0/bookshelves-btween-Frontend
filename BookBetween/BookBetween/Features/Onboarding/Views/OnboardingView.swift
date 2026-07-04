//
//  OnboardingView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingView: View {
  @StateObject private var viewModel = OnboardingViewModel()

  var body: some View {
    self.currentPageView
      .overlay(alignment: .top) {
        self.topBar
          .padding(.horizontal, 24)
          .padding(.top, 70)
      }
      .overlay(alignment: .bottom) {
        self.bottomControls
          .padding(.horizontal, 29)
          .padding(.bottom, 32)
      }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  @ViewBuilder
  private var currentPageView: some View {
    switch self.viewModel.currentPageIndex {
    case 0:
      OnboardingFirstPageView(page: self.viewModel.currentPage)

    case 1:
      OnboardingSecondPageView(page: self.viewModel.currentPage)

    default:
      OnboardingThirdPageView(page: self.viewModel.currentPage)
    }
  }

  private var topBar: some View {
    HStack {
      Button {
      } label: {
        Image(systemName: "chevron.left")
          .font(.system(size: 28, weight: .regular))
          .foregroundStyle(Color.gray500)
      }

      Spacer()

      Button {
        self.viewModel.skipButtonDidTap()
      } label: {
        Text("건너뛰기")
          .body2RegularStyle
          .foregroundStyle(Color.gray500)
      }
    }
  }

  private var bottomControls: some View {
    VStack(spacing: 0) {
      OnboardingPageIndicator(
        currentPage: self.viewModel.currentPageIndex,
        totalPage: self.viewModel.pages.count
      )
      .padding(.bottom, 32)

      OnboardingBottomButton(title: self.viewModel.bottomButtonTitle) {
        self.viewModel.nextButtonDidTap()
      }
    }
  }

}

#Preview {
  OnboardingView()
}
