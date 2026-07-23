//
//  ProfileEditView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 프로필 수정 화면

struct ProfileEditView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.beige100
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ProfileEditHeaderView {
                        dismiss()
                    }

                    // 프로필 수정 콘텐츠 영역
                }
                .padding(.bottom, 40)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - 상단 헤더

private struct ProfileEditHeaderView: View {
    let onBack: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 12) {
                Button(action: onBack) {
                    Image("icon_arrow_left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(.plain)

                Text("계정설정")
                    .head1Style
                    .foregroundStyle(Color.gray900)

                Spacer()
            }

            Text("나만의 독서 경험을 설정해 보세요")
                .body2RegularStyle
                .foregroundStyle(Color.gray600)
                .padding(.leading, 36)
        }
        .padding(.horizontal, 28)
        .padding(.top, 12)
        .padding(.bottom, 32)
    }
}

#Preview {
    NavigationStack {
        ProfileEditView()
    }
}
