import SwiftUI

struct BookMeetingResultView: View {
	let meeting: BookMeeting

	private var discussion: BookMeetingDiscussion {
		BookMeetingDiscussion(
			meeting: self.meeting,
			topics: [
				DiscussionTopic(
					id: 1,
					question: "왜 싯다르타는 계속 떠났을까?",
					content: "많은 참여자들은 싯다르타가 깨달음을 얻기 위해서가 아니라, 타인의 답을 자신의 답으로 받아들일 수 없었기 때문에 떠났다고 이야기했다.",
					quote: nil
				),
				DiscussionTopic(
					id: 2,
					question: "가장 인상 깊었던 시기",
					content: "참여자들은 의외로 싯다르타가 성공과 쾌락을 경험하던 시기를 많이 언급했다. 완벽한 실패와 방황과 실패의 시간이 있었기에 마지막 깨달음이 의미 있게 다가왔다는 의견이 많았다.",
					quote: nil
				),
				DiscussionTopic(
					id: 3,
					question: "현재의 나와 연결되는 부분",
					content: "많은 참여자들이 진로 고민, 인간관계, 미래에 대한 불안을 이야기하며 싯다르타의 방황과 자신의 삶을 연결 지었다. 특히 '남들과 비교하여 조급해질 때가 많다.'는 이야기에 여러 참여자가 공감했다.",
					quote: nil
				)
			],
			keywords: []
		)
	}

	var body: some View {
		ZStack {
			gradientBackground
            leafDecoration
            VStack(spacing: 0) {
                HStack {
                    Text("모임 관리")
                        .head2Style
                    Spacer()
                }
                .padding(.horizontal, 30)
                .padding(.top, 17)
                .padding(.bottom, 21)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        bookHeaderSection
                        aiSummarySection
                        discussionSection
                    }
                    .padding(.bottom, 40)
                }
            }
		}
		.navigationBarTitleDisplayMode(.inline)
	}

	// MARK: - Background
    // 수정필요
	private var gradientBackground: some View {
		LinearGradient(
			colors: [
				Color(hex: "DCEBE1").opacity(0.40),
				Color.white
			],
			startPoint: .top,
			endPoint: .bottom
		)
		.ignoresSafeArea()
	}

    // MARK: - LeafDecoration
    //수정필요
    private var leafDecoration: some View {
        Image(.leaf2)
            .resizable()
            .scaledToFit()
            .frame(width: 170)
            .opacity(0.80)
            .rotationEffect(.degrees(-7.87))
            .offset(x: 100, y: -200)
            .allowsHitTesting(false)
    }
    
	// MARK: - Book Header

	private var bookHeaderSection: some View {
		ZStack(alignment: .topTrailing) {
			HStack(alignment: .top, spacing: 16) {
				Image(meeting.book.thumbnailImageName ?? "book_cover_meeting_1")
					.resizable()
					.scaledToFill()
					.frame(width: 104, height: 160)
					.clipped()
					.shadow(color: .black.opacity(0.15), radius: 6, x: -3, y: 3) //수정필요

				VStack(alignment: .leading, spacing: 8) {
					Text(meeting.book.title)
						.head3Style

					Text(meeting.book.author)
						.caption1RegularStyle
						.foregroundStyle(Color.gray500)

                    HStack(spacing: 3) {
						Image(systemName: "star.fill")
							.font(.caption)
							.foregroundStyle(.yellow)
						Text("4.5")
							.body2RegularStyle
					}
					.padding(.bottom, 2)

					compactInfoRows
				}
			}
			.padding(.horizontal, 20)
			.padding(.vertical, 20)
		}
	}

	private var compactInfoRows: some View {
		VStack(alignment: .leading, spacing: 4) {
			compactInfoRow(icon: { Image("icon_calendar") }, text: "독서 기간: 11/25 - 11/28")
			compactInfoRow(icon: { Image("icon_calendar") }, text: "모임 날짜: 11/30 19:00")
			compactInfoRow(icon: { Image(systemName: "clock").foregroundStyle(Color.gray500) }, text: "모임 시간: \(meeting.timerMinutes)분")
			compactInfoRow(icon: { Image("icon_group") }, text: "참여자: \(meeting.maxParticipants)명")
		}
	}

	private func compactInfoRow<Icon: View>(
		@ViewBuilder icon: () -> Icon,
		text: String
	) -> some View {
		HStack(spacing: 4) {
			icon()
			Text(text)
				.caption2RegularStyle
				.foregroundStyle(Color.gray500)
		}
	}

	// MARK: - AI Summary

	private var aiSummarySection: some View {
		HStack(alignment: .top, spacing: 12) {
			ZStack {
				Circle()
					.fill(Color.green50)
					.frame(width: 36, height: 36)
				Image("icon_sparkles")
					.resizable()
					.scaledToFit()
					.frame(width: 18, height: 18)
					.foregroundStyle(Color.green800)
			}

			VStack(alignment: .leading, spacing: 4) {
				Text("AI 요약")
					.caption1SemiBoldStyle
					.foregroundStyle(Color.green800)

				Text("AI가 주요 토론의 내용을 토대하여 핵심 내용을 3가지 주제로 정리했어요.")
					.caption1RegularStyle
					.foregroundStyle(Color.gray600)
			}
		}
		.padding(14)
		.background(Color.white.opacity(0.85))
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
		.padding(.horizontal, 20)
		.padding(.bottom, 24)
	}

	// MARK: - Discussion

	private var discussionSection: some View {
		VStack(spacing: 0) {
			ForEach(discussion.topics.indices, id: \.self) { index in
				topicRow(discussion.topics[index])
			}
		}
	}

	private func topicRow(_ topic: DiscussionTopic) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(String(format: "%02d", topic.id))
				.font(.system(size: 28, weight: .bold))
				.foregroundStyle(Color.green600)

			Text(topic.question)
				.body1SemiBoldStyle
				.foregroundStyle(Color.gray800)

			Text(topic.content)
				.body2RegularStyle
				.foregroundStyle(Color.gray600)
		}
		.padding(.horizontal, 20)
		.padding(.vertical, 20)
	}
}

#Preview {
	NavigationStack {
		BookMeetingResultView(
			meeting: BookMeeting(
				id: "preview-result",
				book: Book(
					id: "book-1",
					title: "빛은 얼마나 깊이 스미는가",
					author: "사브리나 임볼리",
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
				meetingDate: Date(),
				timerMinutes: 30,
				maxParticipants: 6,
				currentParticipants: 6,
				status: .completed
			)
		)
	}
}
