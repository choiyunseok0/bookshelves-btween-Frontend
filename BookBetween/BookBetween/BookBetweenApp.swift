//
//  BookBetweenApp.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon

@main
struct BookBetweenApp: App {
    private let loginViewModel: LoginViewModel

    init() {
        guard let kakaoNativeAppKey = Bundle.main.object(
            forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY"
        ) as? String,
        !kakaoNativeAppKey.isEmpty else {
            preconditionFailure("KAKAO_NATIVE_APP_KEY가 설정되지 않았습니다.")
        }

        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)

        guard let stubBaseURL = URL(
            string: "https://stub.bookbetween.local"
        ) else {
            preconditionFailure("Stub Base URL을 생성하지 못했습니다.")
        }

        self.loginViewModel = LoginViewModel(
            kakaoLoginService: KakaoLoginService(),
            authService: AuthService(
                baseURL: stubBaseURL,
                provider: AuthStubProviderFactory.make(
                    scenario: .pendingOnboarding
                )
            )
        )
    }

    var body: some Scene {
        WindowGroup {
            AppRootView(loginViewModel: loginViewModel)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
