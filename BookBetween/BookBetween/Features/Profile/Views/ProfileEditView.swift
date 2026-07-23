//
//  ProfileEditView.swift
//  BookBetween
//

import SwiftUI

// MARK: - 프로필 수정 화면

struct ProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var generatedNickname = GeneratedNickname.placeholder
    @State private var selectedProfileBackground: ProfileBackgroundColor = .brown

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
                        nickname: generatedNickname.text,
                        onRefresh: {
                            generatedNickname = NicknameGenerator.generate(
                                excluding: generatedNickname.text
                            )
                        }
                    )

                    ProfileAppearanceSectionView(
                        animalImageName: generatedNickname.animalImageName,
                        selectedBackground: $selectedProfileBackground
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

// MARK: - 프로필 설정 영역

private struct ProfileAppearanceSectionView: View {
    let animalImageName: String
    @Binding var selectedBackground: ProfileBackgroundColor

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("프로필")
                .head3Style
                .foregroundStyle(Color.gray700)

            Text("프로필 배경색과 캐릭터를 변경할 수 있어요.")
                .caption1RegularStyle
                .foregroundStyle(Color.gray500)

            HStack(spacing: 27) {
                ZStack {
                    Circle()
                        .fill(selectedBackground.gradient)

                    Image(animalImageName)
                        .resizable()
                        .scaledToFit()
                }
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.white, lineWidth: 1.5)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("배경색 선택")
                        .caption1RegularStyle
                        .foregroundStyle(Color.gray700)

                    HStack(spacing: 8) {
                        ForEach(ProfileBackgroundColor.allCases) { background in
                            ProfileBackgroundColorButton(
                                background: background,
                                isSelected: selectedBackground == background
                            ) {
                                selectedBackground = background
                            }
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding(.leading, 28)
        .padding(.vertical, 19.5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 155, alignment: .leading)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.white, location: 0.26),
                    Gradient.Stop(
                        color: Color(red: 0.86, green: 0.92, blue: 0.88),
                        location: 1
                    )
                ],
                startPoint: UnitPoint(x: 1.02, y: -0.33),
                endPoint: UnitPoint(x: 0.26, y: 1)
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.75)
                .stroke(Color.white, lineWidth: 1.5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 28)
    }
}

// MARK: - 프로필 배경색 버튼

private struct ProfileBackgroundColorButton: View {
    let background: ProfileBackgroundColor
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(background.gradient)
                .frame(width: 22, height: 22)
                .overlay {
                    Circle()
                        .stroke(
                            isSelected ? Color.green500 : Color.white,
                            lineWidth: 1
                        )
                }
                .shadow(
                    color: Color(hex: "2B2A28").opacity(0.1),
                    radius: 2, x: 0,y: 2
                )
        }
    }
}

// MARK: - 프로필 배경색

private enum ProfileBackgroundColor: CaseIterable, Identifiable {
    case brown
    case lightGreen
    case skyBlue
    case orange
    case purple
    case yellow

    var id: Self { self }

    var gradient: LinearGradient {
        switch self {
        case .orange:
            return standardGradient(
                endColor: Color(red: 1, green: 0.46, blue: 0.3)
            )
        case .yellow:
            return standardGradient(
                endColor: Color(red: 0.94, green: 0.79, blue: 0.37)
            )
        case .brown:
            return standardGradient(
                endColor: Color(red: 0.69, green: 0.5, blue: 0.28)
            )
        case .purple:
            return standardGradient(
                endColor: Color(red: 0.47, green: 0.47, blue: 0.75)
            )
        case .skyBlue:
            return standardGradient(
                endColor: Color(red: 0.51, green: 0.73, blue: 0.96)
            )
        case .lightGreen:
            return standardGradient(
                endColor: Color(red: 0.6, green: 0.76, blue: 0.65)
            )
        }
    }

    private func standardGradient(
        startColor: Color = Color.white.opacity(0.4),
        endColor: Color
    ) -> LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: startColor, location: 0),
                Gradient.Stop(color: endColor, location: 1)
            ],
            startPoint: UnitPoint(x: -0.17, y: 0.17),
            endPoint: UnitPoint(x: 1.17, y: 0.83)
        )
    }
}

#Preview {
    NavigationStack {
        ProfileEditView()
    }
}
