//
//  MemberProfile.swift
//  BookBetween
//

import Foundation

nonisolated struct MemberProfile: Equatable {
    let memberId: Int
    let nickname: String
    let nicknameNoun: String
    let nicknameModifier: String
    let nicknameAnimal: String
    let profileBackgroundColor: String
    let joinedDays: Int
    let categories: [MemberCategory]
}

nonisolated struct MemberCategory: Equatable, Identifiable {
    let categoryId: Int
    let name: String

    var id: Int {
        categoryId
    }
}
