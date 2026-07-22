//
//  ProfileView.swift
//  BookBetween
//
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("마이페이지")
                    .head2Style
                    .foregroundStyle(Color.gray900)
                    .padding(.bottom, 16)

                profileCard
                    .padding(.bottom, 50)

                readingStatisticsCard
                    .padding(.bottom, 16)

                Text("독서 캘린더")
                    .head2Style
                    .foregroundStyle(Color.gray900)
                    .padding(.bottom, 18)

                readingCalendar
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 120)
        }
        .background(Color.beige100)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var profileCard: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(height: 130)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray200, lineWidth: 0.5)
            }
    }

    private var readingStatisticsCard: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(height: 110)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray200, lineWidth: 0.5)
            }
    }

    private var readingCalendar: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(height: 391)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray300, lineWidth: 0.5)
            }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
