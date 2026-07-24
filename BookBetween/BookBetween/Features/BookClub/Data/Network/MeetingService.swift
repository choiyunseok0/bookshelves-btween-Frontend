//
//  MeetingService.swift
//  BookBetween
//

import Foundation
import Moya

protocol MeetingServiceProtocol {
    func fetchMeetingDetail(meetingId: Int) async throws -> BookMeeting
}

final class MeetingService: MeetingServiceProtocol {
    private let baseURL: URL
    private let provider: MoyaProvider<MeetingTarget>
    private let requestExecutor: AuthenticatedRequestExecutor

    init(configuration: NetworkConfiguration) {
        self.baseURL = configuration.baseURL
        self.provider = MoyaProvider<MeetingTarget>(
            plugins: [
                AuthorizationPlugin(accessToken: configuration.accessToken)
            ]
        )
        self.requestExecutor = AuthenticatedRequestExecutor(
            reissueTokens: configuration.reissueTokens
        )
    }

    init(baseURL: URL, provider: MoyaProvider<MeetingTarget>) {
        self.baseURL = baseURL
        self.provider = provider
        self.requestExecutor = AuthenticatedRequestExecutor(
            reissueTokens: nil
        )
    }

    func fetchMeetingDetail(meetingId: Int) async throws -> BookMeeting {
        try await requestExecutor.execute {
            do {
                let response = try await provider.requestAsync(
                    MeetingTarget(
                        baseURL: baseURL,
                        endpoint: .getMeetingDetail(meetingId: meetingId)
                    )
                )
                let result = try response.decodePayload(MeetingResultDTO.self)
                return try result.toDomain()
            } catch let error as MoyaError {
                throw NetworkError.transport(error)
            }
        }
    }
}
