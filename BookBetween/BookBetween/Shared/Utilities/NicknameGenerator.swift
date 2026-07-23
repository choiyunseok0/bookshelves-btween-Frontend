//
//  NicknameGenerator.swift
//  BookBetween
//

import Foundation

// MARK: - 랜덤 닉네임 생성기

enum NicknameGenerator {
    // MARK: - 랜덤 닉네임 단어 목록

    private static let subjects = [
        "책", "문장", "책장", "책갈피", "서재", "소설", "시집", "단어",
        "문단", "페이지", "표지", "잉크", "글자", "필사", "목차", "여백",
        "문고", "도서", "장면", "구절", "결말", "북마크", "책등", "한줄평",
        "동화", "고전", "이야기", "책방", "도서관"
    ]

    private static let adjectives = [
        "먹는", "읽는", "빌리는", "엎는", "던지는", "모으는", "여는",
        "덮는", "고르는", "숨기는", "줍는", "찾는", "따라가는", "물고 온",
        "기다리는", "속삭이는", "좋아하는", "기록하는", "간직하는", "훔치는",
        "지키는", "넘기는", "쌓는", "적는", "옮기는", "나르는"
    ]

    private static let animals = [
        "여우", "악어", "호랑이", "코끼리", "두더지", "고슴도치", "기린",
        "고양이", "부엉이", "강아지", "올빼미", "참새", "독수리", "뻐꾸기",
        "여행자", "수달", "표범", "거북이", "치타", "원숭이", "곰", "사슴",
        "해파리", "범고래", "뱀", "햄스터", "금붕어"
    ]

    // MARK: - 랜덤 닉네임 생성

    static func generate(excluding currentNickname: String? = nil) -> String {
        var nickname = makeNickname()

        while nickname == currentNickname {
            nickname = makeNickname()
        }

        return nickname
    }

    private static func makeNickname() -> String {
        guard
            let subject = subjects.randomElement(),
            let adjective = adjectives.randomElement(),
            let animal = animals.randomElement()
        else {
            return "책 먹는 여우"
        }

        return "\(subject) \(adjective) \(animal)"
    }
}
