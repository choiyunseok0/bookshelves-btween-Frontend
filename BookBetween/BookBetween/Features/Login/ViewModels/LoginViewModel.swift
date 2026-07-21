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
    private let authService: AuthServiceProtocol

    private(set) var state: LoginViewState = .idle

    var isLoading: Bool {
        state == .loading
    }

    init(authService: AuthServiceProtocol) {
        self.authService = authService
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
            let result = try await authService.socialLogin(
                provider: provider,
                providerToken: providerToken
            )
            state = try Self.makeSuccessState(from: result)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func resetState() {
        state = .idle
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
