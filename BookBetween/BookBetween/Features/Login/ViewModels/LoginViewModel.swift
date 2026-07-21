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

    private(set) var state: LoginViewState = .idle

    var isLoading: Bool {
        state == .loading
    }

    init(
        kakaoLoginService: KakaoLoginServiceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.kakaoLoginService = kakaoLoginService
        self.authService = authService
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

        return try Self.makeSuccessState(from: result)
    }

    private static func makeSuccessState(
        from result: SocialLoginResultDTO
    ) throws -> LoginViewState {
        switch result.memberStatus {
        case .pendingOnboarding:
            try validateServiceTokens(in: result)
            return .success(.accountSetup)

        case .active:
            try validateServiceTokens(in: result)
            return .success(.main)

        case .withdrawn:
            guard let restoreToken = result.restoreToken,
                  !restoreToken.isEmpty else {
                throw LoginViewModelError.missingRestoreToken
            }
            return .success(.accountRecovery)

        case .suspended:
            throw LoginViewModelError.suspendedMember

        case .anonymized:
            throw LoginViewModelError.unexpectedMemberStatus
        }
    }

    private static func validateServiceTokens(
        in result: SocialLoginResultDTO
    ) throws {
        guard let accessToken = result.accessToken,
              !accessToken.isEmpty,
              let refreshToken = result.refreshToken,
              !refreshToken.isEmpty else {
            throw LoginViewModelError.missingServiceTokens
        }
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
