//
//  CalendarDay.swift
//  BookBetween
//

import Foundation

// MARK: - 캘린더 날짜 모델

struct CalendarDay: Identifiable {
    let date: Date
    let day: Int
    let isCurrentMonth: Bool

    var id: Date { date }
}
