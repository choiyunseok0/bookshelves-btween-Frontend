//
//  TokenReissueDTO.swift
//  BookBetween
//

import Foundation

nonisolated struct TokenReissueRequestDTO: Encodable {
    let refreshToken: String
}

nonisolated struct TokenReissueResultDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let accessTokenExpiresIn: Int
    let refreshTokenExpiresIn: Int
}
