import SwiftUI

struct BookMeetingDetailView: View {
    @Environment(\.dismiss) private var dismiss //탭시 이전화면으로 돌아감
    
	let meeting: BookMeeting

	var body: some View {
		VStack(spacing: 0) {
            HStack(spacing: 12) {
                Button {
                    dismiss()
                } label: {
                    Image(.iconChevronRightGray2)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipped()
                }

                Text("독서 모임 참여하기")
                    .head2Style

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 1)
            .padding(.bottom, 7)
            
            HStack{
                Text("????")
                    .caption1RegularStyle
                    .foregroundStyle(Color.gray500)
                Spacer()
            }
            .padding(.horizontal, 62)
            .padding(.bottom, 12)
            
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					bookHeaderSection
					descriptionText
					meetingInfoSection
				}
				.padding(.bottom, 20)
			}

			bottomButton("모임 참여하기") {}
		}
		.toolbar(.hidden, for: .navigationBar)
	}

	// MARK: - Header

	private var bookHeaderSection: some View {
		HStack(alignment: .top, spacing: 14) {
			Image(meeting.book.thumbnailImageName ?? "book_cover_1")
				.resizable()
				.scaledToFill()
				.frame(width: 130, height: 189)
				.clipped()
				.shadow(color: .black.opacity(0.1), radius: 4, x: -4, y: 4)

			VStack(alignment: .leading, spacing: 6) {
				Text(meeting.book.title)
					.head1Style

				Text(meeting.book.author)
					.caption1RegularStyle //수정필요
					.foregroundStyle(Color.gray500)

				if let genre = meeting.book.genre {
					Text(genre)
						.caption1SemiBoldStyle
						.foregroundStyle(Color.white)
						.padding(.horizontal, 10)
						.padding(.vertical, 2)
						.background(Color.green600)
						.clipShape(Capsule())
				}
			}
		}
        .padding(.horizontal, 30)
        .padding(.bottom, 21) //피그마수정필요
	}

	@ViewBuilder
	private var descriptionText: some View {
		if let description = meeting.book.description, !description.isEmpty {
			Text(description)
				.body2RegularStyle
				.foregroundStyle(Color.gray600)
				.padding(.horizontal, 20)
				.padding(.top, 16)
		}
	}

	// MARK: - Meeting Info

	private var meetingInfoSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("모임정보")
				.body1SemiBoldStyle
				.padding(.horizontal, 20)

			meetingInfoCard
				.padding(.horizontal, 20)
		}
		.padding(.top, 24)
	}

	private var meetingInfoCard: some View {
		VStack(spacing: 0) {
			infoRow(icon: { Image("icon_calendar") }, label: "모임 날짜", value: meetingDateText)
			Divider()
			infoRow(icon: { Image(systemName: "clock").foregroundStyle(Color.gray500) }, label: "타이머 시간", value: "\(meeting.timerMinutes)분")
			Divider()
			infoRow(icon: { Image("icon_group") }, label: "참여자", value: "\(meeting.currentParticipants)/\(meeting.maxParticipants)명")
		}
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
	}

	private func infoRow<Icon: View>(
		@ViewBuilder icon: () -> Icon,
		label: String,
		value: String
	) -> some View {
		HStack {
			icon()
			Text(label)
				.body2RegularStyle
				.foregroundStyle(Color.gray700)
			Spacer()
			Text(value)
				.body2RegularStyle
				.foregroundStyle(Color.gray700)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 14)
	}

	// MARK: - Helpers

	private var meetingDateText: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd HH:mm"
		return formatter.string(from: meeting.meetingDate)
	}
}

// MARK: - Shared Bottom Button

func bottomButton(_ title: String, action: @escaping () -> Void) -> some View {
	Button(action: action) {
		Text(title)
			.body1SemiBoldStyle
			.foregroundStyle(.white)
			.frame(maxWidth: .infinity)
			.padding(.vertical, 16)
			.background(Color.green800)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
	.padding(.horizontal, 20)
	.padding(.top, 8)
	.padding(.bottom, 16)
	.background(.white)
}

#Preview {
	NavigationStack {
		BookMeetingDetailView(
			meeting: BookMeeting(
				id: "preview-detail",
				book: Book(
					id: "book-1",
					title: "혼모노",
					author: "성해나",
					description: "끝없이 '진짜'와 '가짜'의 사이를 오가며 '혼모노'란 무엇인지 그 경계에서 질문을 던지는 소설",
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_1",
					genre: "#한국소설"
				),
				title: nil,
				description: "",
				recruitmentStartDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 18)) ?? Date(),
				recruitmentEndDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 24)) ?? Date(),
				readingStartDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 25)) ?? Date(),
				readingEndDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 28)) ?? Date(),
				meetingDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 19)) ?? Date(),
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 4,
				status: .upcoming
			)
		)
	}
}
