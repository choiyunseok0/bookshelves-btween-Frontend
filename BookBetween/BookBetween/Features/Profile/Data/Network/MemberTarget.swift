//
//  MemberTarget.swift
//  BookBetween
//

import Foundation
import Alamofire
import Moya

nonisolated struct MemberTarget: TargetType, AuthorizationRequirement {
    enum Endpoint {
        case me
    }

    let baseURL: URL
    let endpoint: Endpoint

    var path: String {
        switch endpoint {
        case .me:
            return "/api/v1/members/me"
        }
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        .requestPlain
    }

    var requiresAuthorization: Bool {
        true
    }

    var headers: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}
