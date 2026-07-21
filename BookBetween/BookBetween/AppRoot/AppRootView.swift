//
//  AppRootView.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct AppRootView: View {
    @State private var loginViewModel: LoginViewModel

    init(loginViewModel: LoginViewModel) {
        _loginViewModel = State(initialValue: loginViewModel)
    }

    var body: some View {
        Group {
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
        .animation(.easeInOut, value: loginViewModel.state)
    }
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
