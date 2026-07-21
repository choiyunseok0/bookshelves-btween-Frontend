//
//  AuthService.swift
//  BookBetween
//

import Foundation
import Moya

protocol AuthServiceProtocol {
    func socialLogin(
        provider: SocialProvider,
        providerToken: String
    ) async throws -> SocialLoginResultDTO
}

final class AuthService: AuthServiceProtocol {
    private let baseURL: URL
    private let provider: MoyaProvider<AuthTarget>

    init(configuration: NetworkConfiguration) {
        self.baseURL = configuration.baseURL
        self.provider = MoyaProvider<AuthTarget>()
    }

    init(baseURL: URL, provider: MoyaProvider<AuthTarget>) {
        self.baseURL = baseURL
        self.provider = provider
    }

    func socialLogin(
        provider: SocialProvider,
        providerToken: String
    ) async throws -> SocialLoginResultDTO {
        let request = SocialLoginRequestDTO(
            provider: provider,
            providerToken: providerToken
        )

        do {
            let response = try await self.provider.requestAsync(
                AuthTarget(
                    baseURL: self.baseURL,
                    endpoint: .socialLogin(request)
                )
            )
            return try response.decodePayload(SocialLoginResultDTO.self)
        } catch let error as MoyaError {
            throw NetworkError.transport(error)
        }
    }
}
