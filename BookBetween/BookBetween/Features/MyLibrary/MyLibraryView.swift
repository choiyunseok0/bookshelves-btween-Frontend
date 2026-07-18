//
//  MyLibraryView.swift
//  BookBetween
//

import SwiftUI

struct MyLibraryView: View {
	@State private var viewModel = MyLibraryViewModel()

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("내서재")
					.head1Style
				Spacer()
			}
			.padding(.horizontal, 20)
			.padding(.top, 12)
			.padding(.bottom, 4)

			tabSelector

			ScrollView(showsIndicators: false) {
				VStack(spacing: 12) {
					ForEach(viewModel.filteredRecords, id: \.id) { record in
						MyLibraryBookCardView(record: record)
					}
				}
				.padding(.horizontal, 20)
				.padding(.top, 16)
				.padding(.bottom, 24)
			}
			.scrollBounceBehavior(.basedOnSize)
		}
		.toolbar(.hidden, for: .navigationBar)
	}

	// MARK: - Tab Selector

	private var tabSelector: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 8) {
				ForEach(MyLibraryTab.allCases, id: \.self) { tab in
					tabPill(for: tab)
				}
			}
			.padding(.horizontal, 20)
			.padding(.vertical, 12)
		}
	}

	private func tabPill(for tab: MyLibraryTab) -> some View {
		Button {
			viewModel.selectedTab = tab
		} label: {
			Text(tab.title)
				.caption1SemiBoldStyle
				.foregroundStyle(viewModel.selectedTab == tab ? Color.white : Color.gray500)
				.padding(.horizontal, 12)
				.padding(.vertical, 6)
				.background(viewModel.selectedTab == tab ? Color.green800 : Color.clear)
				.clipShape(Capsule())
				.overlay {
					if viewModel.selectedTab != tab {
						Capsule()
							.stroke(Color.gray300, lineWidth: 1)
					}
				}
		}
	}
}

#Preview {
	NavigationStack {
		MyLibraryView()
	}
}
