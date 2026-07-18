//
//  BookCoverImage.swift
//  BookBetween
//

import SwiftUI

struct BookCoverImage: View {
    let book: Book
    let placeholderImageName: String

    private var coverURL: URL? {
        guard let coverImageUrl = book.coverImageUrl else { return nil }
        return URL(string: coverImageUrl)
    }

    var body: some View {
        AsyncImage(url: coverURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Image(placeholderImageName)
                    .resizable()
                    .scaledToFill()
            }
        }
    }
}
