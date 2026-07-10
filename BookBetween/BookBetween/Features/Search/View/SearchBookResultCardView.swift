//
//  SearchBookResultCardView.swift
//  BookBetween
//
//  Created by 이준성 on 7/9/26.
//

import SwiftUI

struct SearchBookResultCardView: View {
    let book: Book

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(book.thumbnailImageName ?? "book_cover_meeting_2")
                .resizable()
                .scaledToFill()
                .frame(width: 65, height: 95)
                .clipped()
                .shadow(color: .black.opacity(0.12), radius: 2, x: -1, y: 1)

            VStack(alignment: .leading, spacing: 6) {
                Spacer()

                Text(book.title)
                    .body1SemiBoldStyle
                    .foregroundStyle(Color.gray800)
                    .lineLimit(1)

                Text(book.author)
                    .body2RegularStyle
                    .foregroundStyle(Color.gray500)
                    .lineLimit(1)

                Spacer()
            }
            .frame(height: 96)

            Spacer()

            Button {
            } label: {
                HStack(spacing: 4) {
                    Text("더보기")
                        .caption1RegularStyle
                    Image("icon_chevron_right_gray")
                }
                .foregroundStyle(Color.gray500)
            }
            .buttonStyle(.plain)
            .padding(.top, 7)
        }
        .padding(.horizontal, 21)
        .padding(.vertical, 7)
        .frame(height: 110)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray300, lineWidth: 0.5)
        }
        .shadow(color: .black.opacity(0.08), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    SearchBookResultCardView(
        book: Book(
            id: "search-preview",
            title: "혼모노",
            author: "성해나 (창비)",
            thumbnailImageName: "book_cover_meeting_2"
        )
    )
    .padding()
}
