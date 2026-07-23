//
//  ReadingStatisticsSummaryView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 독서 통계 요약 카드

struct ReadingStatisticsSummaryView: View {
    let readBookCount: Int
    let reviewCount: Int
    let averageRating: Double
    let onMore: (() -> Void)?

    init(
        readBookCount: Int,
        reviewCount: Int,
        averageRating: Double,
        onMore: (() -> Void)? = nil
    ) {
        self.readBookCount = readBookCount
        self.reviewCount = reviewCount
        self.averageRating = averageRating
        self.onMore = onMore
    }

    var body: some View {
        VStack(spacing: 4) {
            summaryHeader
            summaryContent
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 13)
        .frame(height: 110)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, lineWidth: 0.5)
        }
    }

    // MARK: - 카드 헤더

    private var summaryHeader: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.green50)

                Image(systemName: "chart.bar")
                    .foregroundStyle(Color.green900)
            }
            .frame(width: 30, height: 30)

            Text("독서 통계")
                .head3Style
                .foregroundStyle(Color.green900)

            Spacer()

            if let onMore {
                Button(action: onMore) {
                    HStack(spacing: 4) {
                        Text("더보기")
                            .caption1RegularStyle

                        Image("icon_chevron_right_gray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 6, height: 12)
                    }
                    .foregroundStyle(Color.gray500)
                }
            }
        }
    }

    // MARK: - 통계 항목

    private var summaryContent: some View {
        HStack(spacing: 0) {
            statisticsItem(title: "읽은 책", value: "\(readBookCount)권")

            statisticsDivider

            statisticsItem(title: "리뷰", value: "\(reviewCount)개")

            statisticsDivider

            statisticsItem(
                title: "평균 별점",
                value: String(format: "%.1f", averageRating),
                showsStar: true
            )
        }
    }

    private func statisticsItem(
        title: String,
        value: String,
        showsStar: Bool = false
    ) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .caption1RegularStyle
                .foregroundStyle(Color.gray800)

            HStack(spacing: 4) {
                if showsStar {
                    Image("icon_star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }

                Text(value)
                    .body1SemiBoldStyle
                    .foregroundStyle(Color.green600)
            }
        }
        .frame(maxWidth: .infinity)
    }

    private var statisticsDivider: some View {
        Rectangle()
            .fill(Color.gray200)
            .frame(width: 0.5, height: 50)
    }
}

#Preview {
    ReadingStatisticsSummaryView(
        readBookCount: 24,
        reviewCount: 17,
        averageRating: 4.0,
        onMore: {}
    )
    .padding()
    .background(Color.beige100)
}
