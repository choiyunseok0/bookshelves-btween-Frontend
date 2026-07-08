//
//  BookClubViewModel.swift
//  BookBetween
//

import Foundation
import Observation

enum BookClubTab: CaseIterable {
	case myMeetings
	case createdMeetings
	case search

	var title: String {
		switch self {
		case .myMeetings: return "참여 모임 관리"
		case .createdMeetings: return "내가 만든 모임"
		case .search: return "모임 검색"
		}
	}

	var horizontalPadding: CGFloat {
		switch self {
        case .myMeetings: return 17.5
		case .createdMeetings: return 12
		case .search: return 13
		}
	}
}

@Observable
final class BookClubViewModel {

	// MARK: - Properties

	var selectedTab: BookClubTab = .myMeetings
	var searchText: String = ""
	var participatingMeetings: [BookMeeting] = []
	var createdMeetings: [BookMeeting] = []

	var searchResults: [BookMeeting] {
		guard !self.searchText.isEmpty else { return [] }
		return (self.participatingMeetings + self.createdMeetings).filter {
			$0.book.title.localizedCaseInsensitiveContains(self.searchText)
		}
	}

	// MARK: - Init

	init() {
		let calendar = Calendar.current
		let date1 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 19, hour: 21)) ?? Date()
		let date2 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 20, hour: 6)) ?? Date()

		self.participatingMeetings = [
			BookMeeting(
				id: "meeting-p-1",
				book: Book(
					id: "book-p-1",
					title: "빛은 얼마나 깊이 스미는가",
					author: "김초엽",
					description: "우주의 끝에서 혼자 깨어난 과학자가 인류를 구하기 위해 사투를 벌이는 이야기. 인간과 외계 생명체의 우정을 따뜻하게 그려낸 SF 소설.",
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_1"
				),
				title: nil,
				description: "",
				recruitmentStartDate: date1,
				recruitmentEndDate: date1,
				readingStartDate: date1,
				readingEndDate: date1,
				meetingDate: date1,
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 2,
				status: .completed
			),
			BookMeeting(
				id: "meeting-p-2",
				book: Book(
					id: "book-p-2",
					title: "혼모노",
					author: "성해나",
					description: nil,
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_2"
				),
				title: nil,
				description: "",
				recruitmentStartDate: date2,
				recruitmentEndDate: date2,
				readingStartDate: date2,
				readingEndDate: date2,
				meetingDate: date2,
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 4,
				status: .upcoming
			),
			BookMeeting(
				id: "meeting-p-3",
				book: Book(
					id: "book-p-3",
					title: "혼모노",
					author: "성해나",
					description: nil,
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_2"
				),
				title: nil,
				description: "",
				recruitmentStartDate: date2,
				recruitmentEndDate: date2,
				readingStartDate: date2,
				readingEndDate: date2,
				meetingDate: date2,
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 4,
				status: .upcoming
			)
		]

		self.createdMeetings = [
			BookMeeting(
				id: "meeting-c-1",
				book: Book(
					id: "book-c-1",
					title: "빛은 얼마나 깊이 스미는가",
					author: "김초엽",
					description: nil,
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_1"
				),
				title: nil,
				description: "",
				recruitmentStartDate: date2,
				recruitmentEndDate: date2,
				readingStartDate: date2,
				readingEndDate: date2,
				meetingDate: date2,
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 2,
				status: .upcoming
			),
			BookMeeting(
				id: "meeting-c-2",
				book: Book(
					id: "book-c-2",
					title: "혼모노",
					author: "성해나",
					description: nil,
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_2"
				),
				title: nil,
				description: "",
				recruitmentStartDate: date2,
				recruitmentEndDate: date2,
				readingStartDate: date2,
				readingEndDate: date2,
				meetingDate: date2,
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 4,
				status: .upcoming
			)
		]
	}
}
