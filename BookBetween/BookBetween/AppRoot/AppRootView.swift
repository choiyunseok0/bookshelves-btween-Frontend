//
//  AppRootView.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct AppRootView: View {
    @AppStorage("hasCompletedIntro")
    private var hasCompletedIntro = false

    @State private var launchPhase: AppLaunchPhase = .splash
    @State private var loginViewModel: LoginViewModel

    init(loginViewModel: LoginViewModel) {
        _loginViewModel = State(initialValue: loginViewModel)
    }

    var body: some View {
        Group {
            switch launchPhase {
            case .splash:
                SplashView()
                    .task {
                        try? await Task.sleep(for: .seconds(1.5))

                        guard !Task.isCancelled else {
                            return
                        }

                        launchPhase = hasCompletedIntro
                            ? .authentication
                            : .landing
                    }

            case .landing:
                LandingView {
                    launchPhase = .onboarding
                }

            case .onboarding:
                OnboardingView {
                    hasCompletedIntro = true
                    launchPhase = .authentication
                }

            case .authentication:
                authenticationContent
            }
        }
        .animation(.easeInOut, value: launchPhase)
        .animation(.easeInOut, value: loginViewModel.state)
    }

    @ViewBuilder
    private var authenticationContent: some View {
        switch loginViewModel.state {
        case .success(.accountSetup):
            AccountSetupView {
                loginViewModel.completeAccountSetup()
            }

        case .success(.main):
            MainTabView()

        case .success(.accountRecovery):
            AccountRecoveryPlaceholderView()

        case .idle, .loading, .failure:
            LoginView(viewModel: loginViewModel)
        }
    }
}

private enum AppLaunchPhase: Equatable {
    case splash
    case landing
    case onboarding
    case authentication
}

private struct AccountRecoveryPlaceholderView: View {
    var body: some View {
        Text("계정 복구 화면 준비 중입니다.")
    }
}

#Preview {
    AppRootView(
        loginViewModel: LoginViewModel(
            kakaoLoginService: PreviewKakaoLoginService(),
            authService: AuthService(
                baseURL: URL(string: "https://stub.bookbetween.local")!,
                provider: AuthStubProviderFactory.make(
                    scenario: .pendingOnboarding
                )
            )
        )
    )
}

private final class PreviewKakaoLoginService: KakaoLoginServiceProtocol {
    func login() async throws -> String {
        "preview-kakao-provider-token"
    }
}
