//
//  MeetingTarget.swift
//  BookBetween
//

import Foundation
import Alamofire
import Moya

struct MeetingTarget: TargetType {
    enum Endpoint {
        case getMeetingDetail(meetingId: Int)
    }

    let baseURL: URL
    let endpoint: Endpoint

    var path: String {
        switch endpoint {
        case .getMeetingDetail(let meetingId):
            return "/api/v1/meetings/\(meetingId)"
        }
    }

    var method: Moya.Method {
        switch endpoint {
        case .getMeetingDetail:
            return .get
        }
    }

    var task: Moya.Task {
        switch endpoint {
        case .getMeetingDetail:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var sampleData: Data {
        Data()
    }
}
