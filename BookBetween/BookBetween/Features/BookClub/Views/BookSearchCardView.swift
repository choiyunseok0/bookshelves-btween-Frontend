import SwiftUI

struct BookSearchCardView: View {
	let book: Book

	var body: some View {
		ZStack(alignment: .center) {
			Color.white

			VStack(alignment: .leading, spacing: 0) {
				BookCoverImage(book: book, placeholderImageName: "book_cover_01")
					.frame(width: 90, height: 145) //수정필요
					.clipped()
                    .padding(.top, 4)
                    .padding(.bottom, 13.69)
                    .shadow3()

                Text(book.title)
                    .body2SemiBoldStyle //수정필요
                    .lineLimit(1)
                    .foregroundStyle(Color.gray800)

                Text(book.publisher.map { "\(book.author) (\($0))" } ?? book.author)
                    .caption1RegularStyle //수정필요
                    .lineLimit(1)
                    .foregroundStyle(Color.gray500)
                
			}
            .padding(.horizontal, 12)
		}
        .frame(width: 116, height: 222)
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.shadow3()
	}
}

#Preview {
	ScrollView(.horizontal, showsIndicators: false) {
		HStack(spacing: 16) {
			BookSearchCardView(book: Book(
				id: 1,
				title: "혼모노",
				author: "성해나",
				publisher: "창비",
				kdcName: "한국소설"
			))
			BookSearchCardView(book: Book(
				id: 2,
				title: "빛은 얼마나 깊이 스미는가",
				author: "김초엽",
				publisher: "창비",
				kdcName: "SF소설"
			))
			BookSearchCardView(book: Book(
				id: 3,
				title: "프로젝트 헤일메리",
				author: "앤디 위어",
				publisher: "알에이치코리아",
				kdcName: "SF소설"
			))
		}
		.padding()
	}
}
