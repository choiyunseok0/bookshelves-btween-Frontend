//
//  AuthTarget.swift
//  BookBetween
//

import Foundation
import Alamofire
import Moya

nonisolated struct AuthTarget: TargetType, AuthorizationRequirement {
    enum Endpoint {
        case socialLogin(SocialLoginRequestDTO)
        case logout
    }

    let baseURL: URL
    let endpoint: Endpoint

    var path: String {
        switch endpoint {
        case .socialLogin:
            return "/api/v1/auth/social-login"
        case .logout:
            return "/api/v1/auth/logout"
        }
    }

    var method: Moya.Method {
        switch endpoint {
        case .socialLogin, .logout:
            return .post
        }
    }

    var task: Moya.Task {
        switch endpoint {
        case .socialLogin(let request):
            return .requestJSONEncodable(request)
        case .logout:
            return .requestPlain
        }
    }

    var requiresAuthorization: Bool {
        switch endpoint {
        case .socialLogin:
            return false
        case .logout:
            return true
        }
    }

    var headers: [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    var sampleData: Data {
        AuthStubScenario.pendingOnboarding.response.data
    }
}
