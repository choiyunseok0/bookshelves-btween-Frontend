//
//  SearchViewModel.swift
//  BookBetween
//
//  Created by 이준성 on 7/8/26.
//

import Foundation
import Observation

@Observable
final class SearchViewModel {
    var searchText: String = ""
    var recentKeywords: [String] = []

    private let books: [BookSearchItem] = [
        BookSearchItem(
            book: Book(
                isbn: "9788936434595",
                title: "혼모노",
                author: "성해나",
                publisher: "창비",
                description: "성해나 작가의 단편 소설집 『혼모노』는 진짜와 가짜, 믿음에 대한 날카로운 질문을 던지는 작품입니다. 표제작 「혼모노」는 신빨을 잃고 20대 애기 무당에게 자리를 빼앗긴 베테랑 무당이 진정한 자신의 정체성을 찾아가는 과정을 그립니다."
            ),
            isSaveable: true
        ),
        BookSearchItem(
            book: Book(
                title: "이끼숲",
                author: "천선란"
            ),
            isSaveable: false
        ),
        BookSearchItem(
            book: Book(
                title: "오만과 편견",
                author: "제인 오스틴"
            ),
            isSaveable: false
        )
    ]

    var searchResults: [BookSearchItem] {
        let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !keyword.isEmpty else { return [] }

        return books.filter {
            $0.book.title.localizedCaseInsensitiveContains(keyword)
            || $0.book.author.localizedCaseInsensitiveContains(keyword)
        }
    }

    func submitSearch() {
        let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !keyword.isEmpty else { return }

        recentKeywords.removeAll { $0 == keyword }
        recentKeywords.insert(keyword, at: 0)
    }

    func selectRecentKeyword(_ keyword: String) {
        searchText = keyword
        submitSearch()
    }

    func removeRecentKeyword(_ keyword: String) {
        recentKeywords.removeAll { $0 == keyword }
    }
}
