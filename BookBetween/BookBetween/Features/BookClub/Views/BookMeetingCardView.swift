//
//  BookMeetingCardView.swift
//  BookBetween
//

import SwiftUI

struct BookMeetingCardView: View {
	let meeting: BookMeeting

	var body: some View {
		HStack(alignment: .top, spacing: 12) {
			Image(meeting.book.thumbnailImageName ?? "book_cover_meeting_1")
				.resizable()
				.scaledToFill()
				.frame(width: 78, height: 112)
				.clipped()
				.shadow(color: .black.opacity(0.1), radius: 3, x: -2, y: 2)

			VStack(alignment: .leading, spacing: 8) {
				HStack(alignment: .top) {
					statusBadge
					Spacer()
					NavigationLink {
						if meeting.status == .completed {
							BookMeetingResultView(meeting: meeting)
						} else {
							BookMeetingDetailView(meeting: meeting)
						}
					} label: {
						Text("더보기 >")
							.caption2RegularStyle
							.foregroundStyle(Color.gray400)
					}
				}

				Text(meeting.book.title)
					.body1SemiBoldStyle
					.lineLimit(2)
					.foregroundStyle(Color.gray800)

				infoRow
			}
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
	}

	// MARK: - Views

	private var statusBadge: some View {
		Text(meeting.status.title)
			.caption1SemiBoldStyle
			.foregroundStyle(meeting.status == .completed ? Color.gray500 : Color.green600)
			.padding(.horizontal, 8)
			.padding(.vertical, 3)
			.background(meeting.status == .completed ? Color.gray100 : Color.green50)
			.clipShape(Capsule())
	}

	private var infoRow: some View {
		HStack(spacing: 4) {
			Image("icon_calendar")
			Text(meetingDateText)
				.caption2RegularStyle
			separator
			Image("icon_group")
			Text("\(meeting.currentParticipants)/\(meeting.maxParticipants)")
				.caption2RegularStyle
			separator
			Image(systemName: "clock")
				.font(.caption2)
			Text("\(meeting.timerMinutes)분")
				.caption2RegularStyle
		}
		.foregroundStyle(Color.gray500)
	}

	private var separator: some View {
		Text("|")
			.caption2RegularStyle
			.foregroundStyle(Color.gray300)
	}

	// MARK: - Helpers

	private var meetingDateText: String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ko_KR")
		formatter.dateFormat = "MM/dd · HH:mm"
		return formatter.string(from: meeting.meetingDate)
	}
}

#Preview {
	NavigationStack {
		VStack(spacing: 12) {
			BookMeetingCardView(
				meeting: BookMeeting(
					id: "preview-1",
					book: Book(
						id: "book-1",
						title: "빛은 얼마나 깊이 스미는가",
						author: "김초엽",
						description: nil,
						thumbnailURL: nil,
						thumbnailImageName: "book_cover_meeting_1"
					),
					title: nil,
					description: "",
					recruitmentStartDate: Date(),
					recruitmentEndDate: Date(),
					readingStartDate: Date(),
					readingEndDate: Date(),
					meetingDate: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 19, hour: 21)) ?? Date(),
					timerMinutes: 45,
					maxParticipants: 6,
					currentParticipants: 2,
					status: .completed
				)
			)
			BookMeetingCardView(
				meeting: BookMeeting(
					id: "preview-2",
					book: Book(
						id: "book-2",
						title: "프로젝트 헤일메리",
						author: "앤디 위어",
						description: nil,
						thumbnailURL: nil,
						thumbnailImageName: "book_cover_meeting_2"
					),
					title: nil,
					description: "",
					recruitmentStartDate: Date(),
					recruitmentEndDate: Date(),
					readingStartDate: Date(),
					readingEndDate: Date(),
					meetingDate: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 20, hour: 6)) ?? Date(),
					timerMinutes: 60,
					maxParticipants: 6,
					currentParticipants: 4,
					status: .upcoming
				)
			)
		}
		.padding()
	}
}
