//
//  MyLibraryBookCardView.swift
//  BookBetween
//

import SwiftUI

struct MyLibraryBookCardView: View {
	let record: UserBookRecord

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .top, spacing: 12) {
				bookCover
				bookInfo
			}

			if let quote = record.memo, !quote.isEmpty {
				Text("\u{201C}\(quote)\u{201D}")
					.caption1RegularStyle
					.foregroundStyle(Color.gray500)
					.lineLimit(2)
			}
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
		.shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
	}

	// MARK: - Views

	private var bookCover: some View {
		BookCoverImage(book: record.book, placeholderImageName: "book_cover_meeting_1")
			.frame(width: 64, height: 88)
			.clipped()
			.shadow(color: .black.opacity(0.1), radius: 2, x: -1, y: 1)
	}

	private var bookInfo: some View {
		VStack(alignment: .leading, spacing: 6) {
			HStack(alignment: .top) {
				Text(record.book.title)
					.body2SemiBoldStyle
					.lineLimit(2)
					Spacer()
					NavigationLink {
						BookRecordDetailView(record: record)
					} label: {
						Text("더보기 >")
							.caption2RegularStyle
						.foregroundStyle(Color.gray400)
				}
			}

			Text(record.book.author)
				.caption1RegularStyle
				.foregroundStyle(Color.gray500)

			HStack(spacing: 4) {
				Image(systemName: "star.fill")
					.font(.caption)
					.foregroundStyle(.yellow)
				Text(ratingText)
					.caption1RegularStyle
					.foregroundStyle(Color.gray700)
			}

			progressBar
		}
	}

	private var progressBar: some View {
		HStack(spacing: 6) {
			GeometryReader { geo in
				let width = geo.size.width
				let filled = width * CGFloat(record.progress) / 100
				ZStack(alignment: .leading) {
					Capsule()
						.fill(Color.gray200)
						.frame(height: 4)
					if record.progress > 0 {
						Capsule()
							.fill(Color.green800)
							.frame(width: filled, height: 4)
					}
					Circle()
						.fill(record.progress > 0 ? Color.green800 : Color.white)
						.overlay(Circle().stroke(Color.green800, lineWidth: 1.5))
						.frame(width: 10, height: 10)
						.offset(x: max(0, min(filled - 5, width - 10)))
				}
				.frame(height: 10)
			}
			.frame(height: 10)

			Text("\(record.progress)%")
				.caption2RegularStyle
				.foregroundStyle(Color.gray500)
				.frame(width: 32, alignment: .trailing)
		}
	}

	// MARK: - Helpers

	private var ratingText: String {
		guard let r = record.rating else { return "-" }
		return String(format: "%.1f", r)
	}
}
