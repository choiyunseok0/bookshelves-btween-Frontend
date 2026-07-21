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
    init() {
        guard let kakaoNativeAppKey = Bundle.main.object(
            forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY"
        ) as? String,
        !kakaoNativeAppKey.isEmpty else {
            preconditionFailure("KAKAO_NATIVE_APP_KEY가 설정되지 않았습니다.")
        }

        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
