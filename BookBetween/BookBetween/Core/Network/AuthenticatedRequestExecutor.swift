//
//  AuthenticatedRequestExecutor.swift
//  BookBetween
//

import Foundation

final class AuthenticatedRequestExecutor {
    private let reissueTokens: (() async throws -> Void)?

    init(
        reissueTokens: (() async throws -> Void)?
    ) {
        self.reissueTokens = reissueTokens
    }

    func execute<Value>(
        _ operation: () async throws -> Value
    ) async throws -> Value {
        do {
            return try await operation()
        } catch {
            guard Self.isUnauthorized(error),
                  let reissueTokens else {
                throw error
            }

            try await reissueTokens()

            // 재발급 후 기존 요청은 한 번만 다시 실행합니다.
            return try await operation()
        }
    }

    private static func isUnauthorized(
        _ error: Error
    ) -> Bool {
        guard let networkError = error as? NetworkError else {
            return false
        }

        switch networkError {
        case .server(let statusCode, _, _):
            return statusCode == 401
        case .transport, .decoding, .emptyResult:
            return false
        }
    }
}
