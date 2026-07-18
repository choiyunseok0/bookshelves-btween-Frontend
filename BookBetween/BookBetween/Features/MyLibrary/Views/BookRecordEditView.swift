//
//  BookRecordEditView.swift
//  BookBetween
//

/*
import SwiftUI

struct BookRecordEditView: View {
	let record: UserBookRecord

	@State private var progress: Int
	@State private var rating: Double
	@State private var memo: String
	@Environment(\.dismiss) private var dismiss

	init(record: UserBookRecord) {
		self.record = record
		self._progress = State(initialValue: record.progress)
		self._rating = State(initialValue: record.rating ?? 0)
		self._memo = State(initialValue: record.memo ?? "")
	}

	var body: some View {
		VStack(spacing: 0) {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					bookHeaderSection
					descriptionText
					progressSection
					ratingSection
					reviewSection
				}
				.padding(.bottom, 20)
			}

			bottomButton("기록 저장하기") {
				dismiss()
			}
		}
		.navigationTitle("책 정보")
		.navigationBarTitleDisplayMode(.large)
	}

	// MARK: - Book Header

	private var bookHeaderSection: some View {
		ZStack(alignment: .topTrailing) {
			leafDecoration

			HStack(alignment: .top, spacing: 14) {
				BookCoverImage(book: record.book, placeholderImageName: "book_cover_meeting_1")
					.frame(width: 100, height: 130)
					.clipped()
					.shadow(color: .black.opacity(0.15), radius: 6, x: -3, y: 3)

				VStack(alignment: .leading, spacing: 6) {
					Text(record.book.title)
						.head3Style

					Text(record.book.author)
						.caption1RegularStyle
						.foregroundStyle(Color.gray500)

					if let kdcName = record.book.kdcName {
						Text(kdcName)
							.caption1SemiBoldStyle
							.foregroundStyle(Color.green800)
							.padding(.horizontal, 8)
							.padding(.vertical, 3)
							.background(Color.green50)
							.clipShape(Capsule())
					}
				}
			}
			.padding(.horizontal, 20)
			.padding(.top, 16)
		}
	}

	private var leafDecoration: some View {
		Image(systemName: "leaf.fill")
			.resizable()
			.scaledToFit()
			.frame(width: 100)
			.foregroundStyle(Color(hex: "C8DDB8").opacity(0.55))
			.rotationEffect(.degrees(-20))
			.offset(x: 10, y: -10)
			.allowsHitTesting(false)
	}

	private var descriptionText: some View {
		Text(record.book.description ?? "")
			.body2RegularStyle
			.foregroundStyle(Color.gray600)
			.padding(.horizontal, 20)
			.padding(.top, 16)
	}

	// MARK: - Sections

	private var progressSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("독서 진행률")
				.body1SemiBoldStyle

			HStack(spacing: 10) {
				Slider(
					value: Binding(
						get: { Double(progress) },
						set: { progress = Int($0.rounded()) }
					),
					in: 0...100,
					step: 1
				)
					.tint(Color.green800)

				Text("\(progress)%")
					.body2RegularStyle
					.foregroundStyle(Color.gray700)
					.frame(width: 44, alignment: .trailing)
			}
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
		.padding(.horizontal, 20)
		.padding(.top, 20)
	}

	private var ratingSection: some View {
		HStack(alignment: .center) {
			VStack(alignment: .leading, spacing: 12) {
				Text("평점")
					.body1SemiBoldStyle

				HStack(spacing: 6) {
					ForEach(1...5, id: \.self) { star in
						Image(systemName: Double(star) <= rating ? "star.fill" : "star")
							.foregroundStyle(Double(star) <= rating ? Color.yellow : Color.gray300)
							.font(.system(size: 24))
							.onTapGesture { rating = Double(star) }
					}
				}
			}

			Spacer()

			Image(systemName: "lock")
				.foregroundStyle(Color.gray300)
				.font(.title2)
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
		.padding(.horizontal, 20)
		.padding(.top, 12)
	}

	private var reviewSection: some View {
		ZStack(alignment: .bottomTrailing) {
			VStack(alignment: .leading, spacing: 12) {
				Text("한줄평")
					.body1SemiBoldStyle

				ZStack(alignment: .topLeading) {
					if memo.isEmpty {
						Text("이 책에 대한 짧은 감상을 남겨주세요.")
							.font(.body2Regular)
							.foregroundStyle(Color.gray400)
							.padding(.top, 8)
							.padding(.leading, 4)
							.allowsHitTesting(false)
					}
					TextEditor(text: $memo)
						.font(.body2Regular)
						.frame(minHeight: 60)
						.scrollContentBackground(Visibility.hidden)
				}
			}

			Image(systemName: "pencil")
				.foregroundStyle(Color.gray400)
				.font(.callout)
				.padding(.bottom, 4)
		}
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
		.padding(.horizontal, 20)
		.padding(.top, 12)
	}
}

#Preview {
	NavigationStack {
		BookRecordEditView(
			record: UserBookRecord(
				book: Book(
					id: 2,
					title: "혼모노",
					author: "성해나",
					description: "성해나 작가의 단편 소설집 혼모노는 진짜와 가짜, 믿음에 대한 날카로운 질문을 던지는 작품입니다.",
					kdcName: "한국소설"
				),
				progress: 100,
				rating: nil,
				memo: nil
			)
		)
	}
}

*/
