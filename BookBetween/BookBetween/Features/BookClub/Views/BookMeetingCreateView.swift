import SwiftUI

struct BookMeetingCreateView: View {
	@Environment(\.dismiss) private var dismiss //탭시 이전화면으로 돌아감
	@State private var meetingDate = Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 10)) ?? Date()
	@State private var timerMinutes = 30
	@State private var maxParticipants = 3
	@State private var showingMeetingDatePicker = false
	@State private var showingTimerPicker = false
	@State private var showingParticipantsPicker = false

	private static let dateTimeFormatter: DateFormatter = {
		let f = DateFormatter()
		f.dateFormat = "MM/dd HH:mm"
		return f
	}()

	let book: Book

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

                Text("독서 모임 생성하기")
                    .head2Style

                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.top, 1)
            .padding(.bottom, 7)
            
            HStack{
                Text("같이 읽을 책과 모임 정보를 설정해주세요")
                    .caption1RegularStyle
                    .foregroundStyle(Color.gray500)
                Spacer()
            }
            .padding(.horizontal, 62)
            .padding(.bottom, 12)
            
            //scrollview에 대한 조건이 피그마에 너무 없어여. 위로 스크롤시 막혀있어야하는지 이런 세부적인 사항은 디자인과 협의 안하고 임의로 수정해도 되는지?
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					bookHeaderSection
					descriptionText
					meetingInfoSection
                    Spacer()
				}
				.padding(.bottom, 20)
			}
            noticeSection
			bottomButton("+ 모임 생성하기") {}
		}
		.toolbar(.hidden, for: .navigationBar)
	}

	// MARK: - Header

	private var bookHeaderSection: some View {
		HStack(alignment: .top, spacing: 16) {
            Image(book.thumbnailImageName ?? "book_cover_1")
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 189)
                .clipped()
                .shadow(color: .black.opacity(0.1), radius: 4, x: -4, y: 4)

            VStack(alignment: .leading, spacing: 6) {
                Text(book.title)
                    .head1Style

                Text(book.author)
                    .caption1RegularStyle //수정필요
                    .foregroundStyle(Color.gray500)

                Text("#한국소설")
                    .caption1SemiBoldStyle
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .background(Color.green600)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 21) //피그마수정필요
	}
    
	private var descriptionText: some View {
		Text(book.description ?? "")
			.body2RegularStyle
			.foregroundStyle(Color.gray600)
			.padding(.horizontal, 30) //피그마수정필요
	}

	// MARK: - Meeting Info
    //휠 조건 백엔드 수정사항 반영 필요
    //모임 날짜 정보가 너무 많아요.. 모임 날짜와 모임 시간 분리할 필요가 있어유
	private var meetingInfoSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("모임정보")
				.body1SemiBoldStyle
			meetingInfoCard
		}
        .padding(.horizontal, 20)
		.padding(.top, 16)
	}

	private var meetingInfoCard: some View {
		VStack(spacing: 0) {
			// 모임 날짜 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingTimerPicker = false
					showingParticipantsPicker = false
					showingMeetingDatePicker.toggle()
				}
			} label: {
				HStack {
					Image("icon_calendar")
					Text("모임 날짜")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text(Self.dateTimeFormatter.string(from: meetingDate))
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingMeetingDatePicker {
				DatePicker("", selection: $meetingDate, displayedComponents: [.date, .hourAndMinute])
					.datePickerStyle(.wheel)
					.labelsHidden()
					.frame(height: 150)
					.clipped()
					.padding(.horizontal, 8)
					.transition(.opacity.combined(with: .move(edge: .top)))
			}

			Divider()

			// 타이머 시간 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingMeetingDatePicker = false
					showingParticipantsPicker = false
					showingTimerPicker.toggle()
				}
			} label: {
				HStack {
					Image(systemName: "clock")
						.foregroundStyle(Color.gray500)
					Text("타이머 시간")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text("\(timerMinutes)분")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingTimerPicker {
				Picker("타이머 시간", selection: $timerMinutes) {
					ForEach(Array(stride(from: 5, through: 80, by: 5)), id: \.self) { minutes in
						Text("\(minutes)분").tag(minutes)
					}
				}
				.pickerStyle(.wheel)
				.frame(height: 150)
				.padding(.horizontal, 8)
				.transition(.opacity.combined(with: .move(edge: .top)))
			}

			Divider()

			// 참여자 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingMeetingDatePicker = false
					showingTimerPicker = false
					showingParticipantsPicker.toggle()
				}
			} label: {
				HStack {
					Image("icon_group")
					Text("참여자")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text("\(maxParticipants)명")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingParticipantsPicker {
				Picker("참여자", selection: $maxParticipants) {
					ForEach(3...20, id: \.self) { count in
						Text("\(count)명").tag(count)
					}
				}
				.pickerStyle(.wheel)
				.frame(height: 150)
				.padding(.horizontal, 8)
				.transition(.opacity.combined(with: .move(edge: .top)))
			}
		}
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
	}

	// MARK: - Notice

	private var noticeSection: some View {
		HStack(alignment: .center, spacing: 12) {
            Image(.leaf3)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .clipped()
			VStack(alignment: .leading, spacing: 4) {
				Text("모임은 타이머 설정 시간 만료 후  자동으로 폭파돼요.")
					.caption1SemiBoldStyle
					.foregroundStyle(Color.green600)

				Text("편안하고 안전한 대화를 위해 최소인원 3명 이상이 필요해요.")
					.caption1RegularStyle
					.foregroundStyle(Color.gray500)
			}
		}
        .padding(.horizontal, 28)
        .padding(.vertical, 12)
		.background(Color.green50)
		.clipShape(RoundedRectangle(cornerRadius: 8))
	}
}

#Preview {
	NavigationStack {
		BookMeetingCreateView(
			book: Book(
				id: "book-create",
				title: "혼모노",
				author: "성해나",
				description: "성해나 작가의 단편 소설집 『혼모노』는 진짜와 가짜, 믿음에 대한 날카로운 질문을 던지는 작품입니다.\n표제작 『혼모노』는 신발을 읽고 20대 애기 무당에게 자리를 빼앗긴 베테랑 무당이 진정한 자신의 정체성을 찾아가는 과정을 그립니다.",
				thumbnailURL: nil,
				thumbnailImageName: "book_cover_1",
				genre: "#한국소설"
			)
		)
	}
}
