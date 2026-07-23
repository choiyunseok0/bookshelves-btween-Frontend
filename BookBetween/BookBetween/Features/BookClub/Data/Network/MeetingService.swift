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

    init(configuration: NetworkConfiguration) {
        self.baseURL = configuration.baseURL
        self.provider = MoyaProvider<MeetingTarget>(
            plugins: [
                AuthorizationPlugin(accessToken: configuration.accessToken)
            ]
        )
    }

    init(baseURL: URL, provider: MoyaProvider<MeetingTarget>) {
        self.baseURL = baseURL
        self.provider = provider
    }

    func fetchMeetingDetail(meetingId: Int) async throws -> BookMeeting {
        do {
            let response = try await provider.requestAsync(
                MeetingTarget(baseURL: baseURL, endpoint: .getMeetingDetail(meetingId: meetingId))
            )
            let result = try response.decodePayload(MeetingResultDTO.self)
            return try result.toDomain()
        } catch let error as MoyaError {
            throw NetworkError.transport(error)
        }
    }
}
