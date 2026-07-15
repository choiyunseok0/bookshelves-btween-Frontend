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
    var isEditing: Bool = false
    var progress: Double
    var rating: Double
    var oneLineReview: String

    init(record: UserBookRecord) {
        self.record = record
        self.progress = record.progress
        self.rating = record.rating ?? 0
        self.oneLineReview = record.oneLineReview ?? ""
    }

    var book: Book {
        record.book
    }

    var hasReview: Bool {
        !oneLineReview.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var reviewPlaceholderText: String {
        hasReview ? oneLineReview : "이 책에 대한 짧은 감상을 남겨주세요."
    }

    func startEditing() {
        isEditing = true
    }

    func updateRating(_ value: Double) {
        guard isEditing else { return }
        rating = min(max(value, 0), 5)
    }

    func saveRecord() {
        let trimmedReview = oneLineReview.trimmingCharacters(in: .whitespacesAndNewlines)
        record.progress = progress
        record.rating = rating > 0 ? rating : nil
        record.oneLineReview = trimmedReview.isEmpty ? nil : trimmedReview
        oneLineReview = record.oneLineReview ?? ""
        isEditing = false
    }
}
