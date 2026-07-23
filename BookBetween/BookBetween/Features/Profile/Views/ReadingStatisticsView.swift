//
//  ReadingStatisticsView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 독서 통계 상세 화면

struct ReadingStatisticsView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.beige100
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ReadingStatisticsHeaderView {
                        dismiss()
                    }

                    ReadingStatisticsSummaryView(
                        readBookCount: 24,
                        reviewCount: 17,
                        averageRating: 4.0
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - 상단 헤더

private struct ReadingStatisticsHeaderView: View {
    let onBack: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image("icon_arrow_left")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }

            Text("독서통계")
                .head1Style
                .foregroundStyle(Color.gray800)

            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 32)
    }
}

#Preview {
    NavigationStack {
        ReadingStatisticsView()
    }
}
