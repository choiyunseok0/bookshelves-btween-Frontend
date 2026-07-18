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
        case .myMeetings: return 10
		case .createdMeetings: return 10
		case .search: return 10
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

	var allBooks: [Book] = [
		Book(id: 101, title: "혼모노", author: "성해나", publisher: "창비", kdcName: "한국소설"),
		Book(id: 102, title: "빛은 얼마나 깊이 스미는가", author: "김초엽", publisher: "창비", kdcName: "SF소설"),
		Book(id: 103, title: "프로젝트 헤일메리", author: "앤디 위어", publisher: "알에이치코리아", kdcName: "SF소설"),
	]

	var recruitingMeetings: [BookMeeting] = []

	var meetingSearchResults: [BookMeeting] {
		guard !searchText.isEmpty else { return [] }
		return recruitingMeetings.filter {
			$0.book.title.localizedCaseInsensitiveContains(searchText)
		}
	}

	var bookSearchResults: [Book] {
		guard !searchText.isEmpty else { return [] }
		return allBooks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
	}

	// MARK: - Init

	init() {
		let calendar = Calendar.current
		let date1 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 19, hour: 21)) ?? Date()
		let date2 = calendar.date(from: DateComponents(year: 2026, month: 6, day: 20, hour: 6)) ?? Date()
		let date3 = calendar.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 19)) ?? Date()
		let date4 = calendar.date(from: DateComponents(year: 2026, month: 12, day: 5, hour: 20)) ?? Date()

		self.recruitingMeetings = [
			BookMeeting(
				id: "recruiting-1",
				book: Book(id: 201, title: "혼모노", author: "성해나", description: "성해나 작가의 단편 소설집 『혼모노』는 진짜와 가짜, 믿음에 대한 날카로운 질문을 던지는 작품입니다.", kdcName: "한국소설"),
				title: nil, description: "",
				recruitmentStartDate: date3, recruitmentEndDate: date3,
				readingStartDate: date3, readingEndDate: date3,
				meetingDate: date3, timerMinutes: 30,
				maxParticipants: 6, currentParticipants: 4,
				status: .recruiting
			),
			BookMeeting(
				id: "recruiting-2",
				book: Book(id: 202, title: "빛은 얼마나 깊이 스미는가", author: "김초엽", description: "우주의 끝에서 혼자 깨어난 과학자가 인류를 구하기 위해 사투를 벌이는 이야기.", kdcName: "SF소설"),
				title: nil, description: "",
				recruitmentStartDate: date4, recruitmentEndDate: date4,
				readingStartDate: date4, readingEndDate: date4,
				meetingDate: date4, timerMinutes: 45,
				maxParticipants: 5, currentParticipants: 2,
				status: .recruiting
			),
			BookMeeting(
				id: "recruiting-3",
				book: Book(id: 203, title: "혼모노", author: "성해나", description: nil, kdcName: "한국소설"),
				title: nil, description: "",
				recruitmentStartDate: date3, recruitmentEndDate: date3,
				readingStartDate: date3, readingEndDate: date3,
				meetingDate: date3, timerMinutes: 60,
				maxParticipants: 4, currentParticipants: 1,
				status: .recruiting
			),
		]

		self.participatingMeetings = [
			BookMeeting(
				id: "meeting-p-1",
				book: Book(
					id: 301,
					title: "빛은 얼마나 깊이 스미는가",
					author: "김초엽",
					description: "우주의 끝에서 혼자 깨어난 과학자가 인류를 구하기 위해 사투를 벌이는 이야기. 인간과 외계 생명체의 우정을 따뜻하게 그려낸 SF 소설."
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
					id: 302,
					title: "혼모노",
					author: "성해나",
					description: nil
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
					id: 303,
					title: "혼모노",
					author: "성해나",
					description: nil
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
					id: 401,
					title: "빛은 얼마나 깊이 스미는가",
					author: "김초엽",
					description: nil
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
					id: 402,
					title: "혼모노",
					author: "성해나",
					description: nil
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
