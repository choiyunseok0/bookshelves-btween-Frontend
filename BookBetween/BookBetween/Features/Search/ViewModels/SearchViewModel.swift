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

    private let books: [Book] = [
        Book(
            id: "search-1",
            title: "혼모노",
            author: "성해나 (창비)",
            description: nil,
            thumbnailURL: nil,
            thumbnailImageName: "book_cover_meeting_2",
            genre: "#한국소설"
        ),
        Book(
            id: "search-2",
            title: "이끼숲",
            author: "천선란",
            description: nil,
            thumbnailURL: nil,
            thumbnailImageName: "book_cover_recommend",
            genre: "#한국소설"
        ),
        Book(
            id: "search-3",
            title: "오만과 편견",
            author: "제인 오스틴",
            description: nil,
            thumbnailURL: nil,
            thumbnailImageName: "book_cover_meeting_1",
            genre: "#영국소설"
        )
    ]

    var searchResults: [Book] {
        let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !keyword.isEmpty else { return [] }

        return books.filter {
            $0.title.localizedCaseInsensitiveContains(keyword)
            || $0.author.localizedCaseInsensitiveContains(keyword)
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
