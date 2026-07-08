import SwiftUI

struct BookClubView: View {
	@State private var viewModel = BookClubViewModel()

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("모임 관리")
					.head2Style
				Spacer()
			}
			.padding(.horizontal, 30)
			.padding(.top, 17)
			.padding(.bottom, 12)

			tabSelector

			ScrollView(showsIndicators: false) {
				VStack(spacing: 12) {
					switch viewModel.selectedTab {
					case .myMeetings:
						meetingList(viewModel.participatingMeetings)
					case .createdMeetings:
						meetingList(viewModel.createdMeetings)
					case .search:
						searchContent
					}
				}
				.padding(.horizontal, 20)
			}
			.scrollBounceBehavior(.basedOnSize)  //콘텐츠가 뷰포트보다 클 때만 바운스
		}
		.toolbar(.hidden, for: .navigationBar)
	}

	// MARK: - Tab Selector

	private var tabSelector: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 8) {
				ForEach(BookClubTab.allCases, id: \.self) { tab in
					tabPill(for: tab)
				}
			}
			.padding(.horizontal, 30)
            .padding(.bottom, 16)
		}
	}

	private func tabPill(for tab: BookClubTab) -> some View {
		Button {
			viewModel.selectedTab = tab
		} label: {
			Text(tab.title)
				.caption1SemiBoldStyle
				.foregroundStyle(viewModel.selectedTab == tab ? Color.beige100 : Color.gray300)
				.padding(.horizontal, tab.horizontalPadding) //viewmodel horizontalpadding 프로퍼티 참고 //수정필요
				.padding(.vertical, 6) //수정필요
				.background(viewModel.selectedTab == tab ? Color.green600 : Color.clear)
				.clipShape(Capsule())
				.overlay {
					if viewModel.selectedTab != tab {
						Capsule()
							.stroke(Color.gray300, lineWidth: 1)
					}
				}
		}
	}

	// MARK: - Content
    //Content 수정필요
	@ViewBuilder
	private func meetingList(_ meetings: [BookMeeting]) -> some View {
		ForEach(meetings, id: \.id) { meeting in
			BookMeetingCardView(meeting: meeting)
		}
	}

	private var searchContent: some View {
		VStack(spacing: 0) {
			searchBar

			if viewModel.searchText.isEmpty {
				EmptyView()
			} else if viewModel.searchResults.isEmpty {
				searchEmptyState
			} else {
				VStack(spacing: 12) {
					ForEach(viewModel.searchResults, id: \.id) { meeting in
						BookMeetingCardView(meeting: meeting)
					}
				}
			}
		}
	}

	private var searchBar: some View {
		HStack(spacing: 8) {
			Image(systemName: "magnifyingglass")
				.foregroundStyle(Color.gray400)

			TextField("모임 검색", text: searchTextBinding)
				.font(.body2Regular)
		}
		.padding(.horizontal, 12)
		.padding(.vertical, 10)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.overlay {
			RoundedRectangle(cornerRadius: 10)
				.stroke(Color.gray300, lineWidth: 1)
		}
	}

	private var searchEmptyState: some View {
		VStack(spacing: 12) {
			Spacer()
				.frame(height: 48)

			Text("현재 진행 중인 독서 모임이 없어요")
				.body1SemiBoldStyle
				.foregroundStyle(Color.gray700)

			Text("새로운 모임을 생성해보세요")
				.body2RegularStyle
				.foregroundStyle(Color.gray400)
				.padding(.bottom, 8)

			NavigationLink(destination: BookMeetingCreateView(book: Book(id: "", title: "", author: ""))) {
				HStack(spacing: 6) {
					Image(systemName: "plus")
					Text("모임 생성하기")
						.body1SemiBoldStyle
				}
				.foregroundStyle(.white)
				.frame(maxWidth: .infinity)
				.padding(.vertical, 14)
				.background(Color.green800)
				.clipShape(RoundedRectangle(cornerRadius: 10))
			}
		}
	}

	// MARK: - Helpers
    // Helpers 수정필요
	private var searchTextBinding: Binding<String> {
		Binding(
			get: { viewModel.searchText },
			set: { viewModel.searchText = $0 }
		)
	}
}

#Preview {
	NavigationStack {
		BookClubView()
	}
}
