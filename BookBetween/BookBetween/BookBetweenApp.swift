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

        guard let apiBaseURL = URL(
            string: "https://api.bookshelves-btween.com"
        ) else {
            preconditionFailure("API Base URL을 생성하지 못했습니다.")
        }

        let authTokenStore = AuthTokenStore()
        let networkConfiguration = NetworkConfiguration(
            baseURL: apiBaseURL,
            accessToken: {
                try? authTokenStore.accessToken()
            }
        )

        self.loginViewModel = LoginViewModel(
            kakaoLoginService: KakaoLoginService(),
            authService: AuthService(
                configuration: networkConfiguration
            ),
            authTokenStore: authTokenStore
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
