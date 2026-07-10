//
//  MainTabView.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabCase = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                NavigationStack {
                    HomeView()
                }
                .tag(TabCase.home)

                NavigationStack {
                    SearchView()
                }
                .tag(TabCase.search)

                NavigationStack {
                    BookClubView()
                }
                .tag(TabCase.bookClub)

                NavigationStack {
                    MyLibraryView()
                }
                .tag(TabCase.myLibrary)

                NavigationStack {
                    ProfileView()
                }
                .tag(TabCase.profile)
            }
            .toolbar(.hidden, for: .tabBar)
            .ignoresSafeArea(.keyboard, edges: .bottom)

            CustomTabBar(selectedTab: $selectedTab)
                .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    MainTabView()
}
