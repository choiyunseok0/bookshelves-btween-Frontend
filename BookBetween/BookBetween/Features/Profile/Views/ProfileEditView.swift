//
//  ProfileEditView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 프로필 수정 화면

struct ProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var nickname = "책 먹는 여우"

    var body: some View {
        ZStack {
            Color.beige100
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    ProfileEditHeaderView {
                        dismiss()
                    }

                    ProfileNicknameSectionView(
                        nickname: nickname,
                        onRefresh: {
                            nickname = NicknameGenerator.generate(
                                excluding: nickname
                            )
                        }
                    )
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
                        .frame(width: 20, height: 20)
                }

                Text("계정설정")
                    .head1Style
                    .foregroundStyle(Color.gray800)

                Spacer()
            }

            Text("나만의 독서 경험을 설정해 보세요")
                .body2RegularStyle
                .foregroundStyle(Color.gray600)
        }
        .padding(.horizontal, 30)
        .padding(.top, 12)
        .padding(.bottom, 32)
    }
}

// MARK: - 닉네임 변경 영역

private struct ProfileNicknameSectionView: View {
    let nickname: String
    let onRefresh: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("닉네임 변경")
                .body1SemiBoldStyle
                .foregroundStyle(Color.gray800)
                .padding(.bottom, 8)

            HStack(spacing: 12) {
                Text(nickname)
                    .body1RegularStyle
                    .foregroundStyle(Color.gray600)
                    .padding(.leading, 9)

                Spacer()

                Button(action: onRefresh) {
                    Image("refresh")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(
                            color: Color(red: 0.98, green: 0.98, blue: 0.99).opacity(0.4),
                            location: 0
                        ),
                        Gradient.Stop(color: Color.white, location: 0.72)
                    ],
                    startPoint: UnitPoint(x: 0.87, y: 0),
                    endPoint: UnitPoint(x: 0.13, y: 1)
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.25)
                    .stroke(Color.gray200, lineWidth: 0.5)
            }

            Text("다른 사용자에게 표시되는 이름이에요.")
                .caption1RegularStyle
                .foregroundStyle(Color.gray600)
                .padding(.top, 8)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 44)
    }
}

#Preview {
    NavigationStack {
        ProfileEditView()
    }
}
