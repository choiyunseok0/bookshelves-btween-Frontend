//
//  GenreChipView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 장르 선택 칩

struct GenreChipView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    private var isTwoLetterGenre: Bool {
        title.count == 2
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .body1SemiBoldStyle
                .foregroundStyle(isSelected ? Color.white : Color.gray500)
                .frame(width: isTwoLetterGenre ? 60 : nil)
                .padding(.horizontal, isTwoLetterGenre ? 0 : 10)
                .frame(height: 30)
                .background(isSelected ? Color.green600 : Color.white)
                .clipShape(Capsule())
                .overlay {
                    Capsule()
                        .stroke(
                            isSelected ? Color.green600 : Color.gray300,
                            lineWidth: 1
                        )
                }
        }
        .buttonStyle(.plain)
    }
}
