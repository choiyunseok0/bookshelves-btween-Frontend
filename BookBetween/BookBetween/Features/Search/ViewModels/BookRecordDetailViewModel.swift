//
//  BookRecordDetailViewModel.swift
//  BookBetween
//
//  Created by 이준성 on 7/11/26.
//

import Foundation
import Observation

@Observable
final class BookRecordDetailViewModel {
    private(set) var record: UserBookRecord
    let isSaveable: Bool
    var isEditing: Bool = false
    var progress: Int
    var rating: Double
    var memo: String

    init(record: UserBookRecord, isSaveable: Bool = true) {
        self.record = record
        self.isSaveable = isSaveable
        self.progress = record.progress
        self.rating = record.rating ?? 0
        self.memo = record.memo ?? ""
    }

    var book: Book {
        record.book
    }

    var hasReview: Bool {
        !memo.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var reviewPlaceholderText: String {
        hasReview ? memo : "이 책에 대한 짧은 감상을 남겨주세요."
    }

    func startEditing() {
        guard isSaveable else { return }
        isEditing = true
    }

    func updateRating(_ value: Double) {
        guard isEditing else { return }
        rating = min(max(value, 0), 5)
    }

    func saveRecord() {
        let trimmedMemo = memo.trimmingCharacters(in: .whitespacesAndNewlines)
        record.progress = progress
        record.rating = rating > 0 ? rating : nil
        record.memo = trimmedMemo.isEmpty ? nil : trimmedMemo
        memo = record.memo ?? ""
        isEditing = false
    }
}
