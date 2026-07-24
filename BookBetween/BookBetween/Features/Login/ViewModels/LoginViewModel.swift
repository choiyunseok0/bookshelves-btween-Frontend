//
//  LoginViewModel.swift
//  BookBetween
//

import Foundation
import Observation

enum LoginDestination: Equatable {
    case accountSetup
    case main
    case accountRecovery
}

enum LoginViewState: Equatable {
    case idle
    case loading
    case success(LoginDestination)
    case failure(String)
}

@MainActor
@Observable
final class LoginViewModel {
    private let kakaoLoginService: KakaoLoginServiceProtocol
    private let authService: AuthServiceProtocol
    private let authTokenStore: AuthTokenStoreProtocol

    private(set) var state: LoginViewState = .idle

    var isLoading: Bool {
        state == .loading
    }

    init(
        kakaoLoginService: KakaoLoginServiceProtocol,
        authService: AuthServiceProtocol,
        authTokenStore: AuthTokenStoreProtocol = AuthTokenStore()
    ) {
        self.kakaoLoginService = kakaoLoginService
        self.authService = authService
        self.authTokenStore = authTokenStore
    }

    func loginWithKakao() async {
        guard !isLoading else {
            return
        }

        state = .loading

        do {
            let providerToken = try await kakaoLoginService.login()
            state = try await requestSocialLogin(
                provider: .kakao,
                providerToken: providerToken
            )
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func socialLogin(
        provider: SocialProvider,
        providerToken: String
    ) async {
        guard !isLoading else {
            return
        }

        state = .loading

        do {
            state = try await requestSocialLogin(
                provider: provider,
                providerToken: providerToken
            )
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func resetState() {
        state = .idle
    }

    func completeAccountSetup() {
        guard state == .success(.accountSetup) else {
            return
        }

        state = .success(.main)
    }

    func logout() async throws {
        try await authService.logout()
        try authTokenStore.clearSession()
        state = .idle
    }

    var errorMessage: String? {
        guard case .failure(let message) = state else {
            return nil
        }

        return message
    }

    private func requestSocialLogin(
        provider: SocialProvider,
        providerToken: String
    ) async throws -> LoginViewState {
        let result = try await authService.socialLogin(
            provider: provider,
            providerToken: providerToken
        )

        return try makeSuccessState(from: result)
    }

    private func makeSuccessState(
        from result: SocialLoginResultDTO
    ) throws -> LoginViewState {
        switch result.memberStatus {
        case .pendingOnboarding:
            let tokens = try Self.serviceTokens(from: result)
            try authTokenStore.replaceWithSession(
                accessToken: tokens.accessToken,
                refreshToken: tokens.refreshToken
            )
            return .success(.accountSetup)

        case .active:
            let tokens = try Self.serviceTokens(from: result)
            try authTokenStore.replaceWithSession(
                accessToken: tokens.accessToken,
                refreshToken: tokens.refreshToken
            )
            return .success(.main)

        case .withdrawn:
            guard let restoreToken = result.restoreToken,
                  !restoreToken.isEmpty else {
                throw LoginViewModelError.missingRestoreToken
            }
            try authTokenStore.replaceWithRestoreToken(restoreToken)
            return .success(.accountRecovery)

        case .suspended:
            throw LoginViewModelError.suspendedMember

        case .anonymized:
            throw LoginViewModelError.unexpectedMemberStatus
        }
    }

    private static func serviceTokens(
        from result: SocialLoginResultDTO
    ) throws -> (accessToken: String, refreshToken: String) {
        guard let accessToken = result.accessToken,
              !accessToken.isEmpty,
              let refreshToken = result.refreshToken,
              !refreshToken.isEmpty else {
            throw LoginViewModelError.missingServiceTokens
        }

        return (accessToken, refreshToken)
    }

}

private enum LoginViewModelError: LocalizedError {
    case missingServiceTokens
    case missingRestoreToken
    case suspendedMember
    case unexpectedMemberStatus

    var errorDescription: String? {
        switch self {
        case .missingServiceTokens:
            return "로그인 토큰을 확인할 수 없습니다. 다시 시도해주세요."
        case .missingRestoreToken:
            return "계정 복구 정보를 확인할 수 없습니다. 다시 로그인해주세요."
        case .suspendedMember:
            return "이용이 정지된 계정입니다."
        case .unexpectedMemberStatus:
            return "로그인 상태를 확인할 수 없습니다. 다시 시도해주세요."
        }
    }
}
