//
//  MemberProfileDTO.swift
//  BookBetween
//

import Foundation

nonisolated struct MemberProfileResultDTO: Decodable {
    let memberId: Int
    let nickname: String
    let nicknameNoun: String
    let nicknameModifier: String
    let nicknameAnimal: String
    let profileBackgroundColor: String
    let joinedDays: Int
    let categories: [MemberCategoryDTO]

    func toDomain() -> MemberProfile {
        MemberProfile(
            memberId: memberId,
            nickname: nickname,
            nicknameNoun: nicknameNoun,
            nicknameModifier: nicknameModifier,
            nicknameAnimal: nicknameAnimal,
            profileBackgroundColor: profileBackgroundColor,
            joinedDays: joinedDays,
            categories: categories.map { $0.toDomain() }
        )
    }
}

nonisolated struct MemberCategoryDTO: Decodable {
    let categoryId: Int
    let name: String

    func toDomain() -> MemberCategory {
        MemberCategory(
            categoryId: categoryId,
            name: name
        )
    }
}
