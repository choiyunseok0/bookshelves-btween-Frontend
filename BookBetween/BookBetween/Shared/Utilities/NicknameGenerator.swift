//
//  NicknameGenerator.swift
//  BookBetween
//

import Foundation

// MARK: - 랜덤 닉네임 생성기

struct GeneratedNickname {
    let text: String
    let animalImageName: String

    static let placeholder = GeneratedNickname(
        text: "책 먹는 여우",
        animalImageName: "ex_animal"
    )
}

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

    private static let animals: [NicknameAnimal] = [
        NicknameAnimal(name: "곰", imageName: "animal_bear"),
        NicknameAnimal(name: "다람쥐", imageName: "animal_squirrel"),
        NicknameAnimal(name: "고슴도치", imageName: "animal_hedgehog"),
        NicknameAnimal(name: "나무늘보", imageName: "animal_sloth"),
        NicknameAnimal(name: "올빼미", imageName: "animal_owl"),
        NicknameAnimal(name: "너구리", imageName: "animal_raccoon"),
        NicknameAnimal(name: "북극곰", imageName: "animal_polar_bear"),
        NicknameAnimal(name: "판다", imageName: "animal_panda"),
        NicknameAnimal(name: "코알라", imageName: "animal_koala"),
        NicknameAnimal(name: "코끼리", imageName: "animal_elephant"),
        NicknameAnimal(name: "고래", imageName: "animal_whale"),
        NicknameAnimal(name: "상어", imageName: "animal_shark"),
        NicknameAnimal(name: "펭귄", imageName: "animal_penguin"),
        NicknameAnimal(name: "악어", imageName: "animal_crocodile"),
        NicknameAnimal(name: "개구리", imageName: "animal_frog"),
        NicknameAnimal(name: "거북이", imageName: "animal_turtle"),
        NicknameAnimal(name: "토끼", imageName: "animal_rabbit"),
        NicknameAnimal(name: "수달", imageName: "animal_otter"),
        NicknameAnimal(name: "비버", imageName: "animal_beaver"),
        NicknameAnimal(name: "얼룩말", imageName: "animal_zebra"),
        NicknameAnimal(name: "사자", imageName: "animal_lion"),
        NicknameAnimal(name: "호랑이", imageName: "animal_tiger"),
        NicknameAnimal(name: "치타", imageName: "animal_cheetah"),
        NicknameAnimal(name: "기린", imageName: "animal_giraffe")
    ]

    // MARK: - 랜덤 닉네임 생성

    static func generate(excluding currentNickname: String? = nil) -> GeneratedNickname {
        var nickname = makeNickname()

        while nickname.text == currentNickname {
            nickname = makeNickname()
        }

        return nickname
    }

    private static func makeNickname() -> GeneratedNickname {
        guard
            let subject = subjects.randomElement(),
            let adjective = adjectives.randomElement(),
            let animal = animals.randomElement()
        else {
            return .placeholder
        }

        return GeneratedNickname(
            text: "\(subject) \(adjective) \(animal.name)",
            animalImageName: animal.imageName
        )
    }
}

// MARK: - 닉네임 동물 정보

private struct NicknameAnimal {
    let name: String
    let imageName: String
}
