//
//  SearchView.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                TitleView
                SearchInputSectionView
                SearchResultSectionView
            }
            .scrollDismissesKeyboard(.interactively)
            .contentShape(Rectangle())
            .onTapGesture {
                isSearchFocused = false
            }
            .padding(.horizontal, 19)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    // MARK: 도서검색 TITLE
    private var TitleView: some View {
        HStack {
            Text("도서 검색")
                .head2Style
                .foregroundStyle(Color.gray900)
            Spacer()
        }
        .padding(.leading, 11) // 11 + 19 = 30
    }
    
    // MARK: - 검색 바
    private var SearchInputSectionView: some View {
        VStack(spacing: 0) {
            SearchBarView

            if !viewModel.recentKeywords.isEmpty {
                Divider()
                    .background(.gray200)
                    .padding(.horizontal, 20)
                RecentSearchListView
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, lineWidth: 0.5)
        )
        .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
    }
    
    private var SearchBarView: some View {
        HStack(spacing: 10) {
            Image(.iconMagnifyingglass)
                .foregroundStyle(Color.gray600)

            TextField("검색어를 입력하세요", text: $viewModel.searchText)
                .font(.body1Regular)
                .foregroundStyle(Color.gray800)
                .focused($isSearchFocused)
                .onSubmit {
                    viewModel.submitSearch()
                }
        }
        .frame(height: 46)
        .padding(.horizontal, 11)
    }
    
    private var RecentSearchListView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("최근 검색 도서")
                .body2SemiBoldStyle
                .foregroundStyle(Color.gray600)
                .padding(.top, 11)

            VStack(spacing: 7) {
                ForEach(viewModel.recentKeywords, id: \.self) { keyword in
                    RecentKeywordRow(
                        keyword: keyword,
                        onSelect: {
                            viewModel.selectRecentKeyword(keyword)
                            isSearchFocused = true
                        },
                        onDelete: {
                            viewModel.removeRecentKeyword(keyword)
                        }
                    )
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.bottom, 13)
    }
    
    private var SearchResultSectionView: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.searchResults, id: \.listID) { item in
                SearchBookResultCardView(item: item)
            }
        }
    }
}

private struct RecentKeywordRow: View {
    let keyword: String
    let onSelect: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Button(action: onSelect) {
                Text(keyword)
                    .body2RegularStyle
                    .foregroundStyle(Color.gray600)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .buttonStyle(.plain)

            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(Color.gray500)
                    .frame(width: 12, height: 12)
            }
            .buttonStyle(.plain)
        }
        .frame(height: 18)
    }
}

#Preview {
    SearchView()
}
