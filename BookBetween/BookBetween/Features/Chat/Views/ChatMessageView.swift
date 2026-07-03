//
//  ChatMessageView.swift
//  BookBetween
//
//  Created by 한지민 on 7/4/26.
//

import SwiftUI

struct ChatMessageView: View {
  let nickname: String
  let message: String
  let time: String
  let isMyMessage: Bool
  let profileImageName: String?

  var body: some View {
    if isMyMessage {
      myMessageView
    } else {
      otherMessageView
    }
  }

  // MARK: - My Message

  private var myMessageView: some View {
    VStack(alignment: .trailing, spacing: 0) {
      Text("나")
        .caption1RegularStyle
        .foregroundStyle(.gray600)

      HStack(alignment: .bottom, spacing: 1.57) {
        Text(time)
          .caption2RegularStyle
          .foregroundStyle(.gray300)

        Text(message)
          .body2RegularStyle
          .foregroundStyle(.white)
          .padding(.horizontal, 12.43)
          .padding(.vertical, 8.28)
          .background(.green500)
          .clipShape(
            UnevenRoundedRectangle(
              topLeadingRadius: 18.64,
              bottomLeadingRadius: 18.64,
              bottomTrailingRadius: 18.64,
              topTrailingRadius: 6.21
            )
          )
          .shadow(color: .black.opacity(0.1), radius: 2, x: -2, y: 2)
      }
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }

  // MARK: - Other Message

  private var otherMessageView: some View {
    HStack(alignment: .top, spacing: 5.01) {
      Circle()
        .fill(.gray300)
        .frame(width: 34.99, height: 34.99)
        .overlay {
          if let imageName = profileImageName {
            Image(imageName)
              .resizable()
              .scaledToFill()
              .clipShape(Circle())
          }
        }
        .shadow(color: .black.opacity(0.1), radius: 2, x: -2, y: 2)

      VStack(alignment: .leading, spacing: 3) {
        Text(nickname)
          .caption1SemiBoldStyle
          .foregroundStyle(.gray600)
          .padding(.leading, 4.14)

        HStack(alignment: .bottom, spacing: 1.57){
          Text(message)
            .body2RegularStyle
            .foregroundStyle(.gray800)
            .padding(.horizontal, 12.43)
            .padding(.vertical, 8.28)
            .frame(minHeight: 38.57)
            .background(.white)
            .clipShape(
              UnevenRoundedRectangle(
                topLeadingRadius: 6.21,
                bottomLeadingRadius: 18.64,
                bottomTrailingRadius: 18.64,
                topTrailingRadius: 18.64
              )
            )
            .overlay {
              UnevenRoundedRectangle(
                topLeadingRadius: 6.21,
                bottomLeadingRadius: 18.64,
                bottomTrailingRadius: 18.64,
                topTrailingRadius: 18.64
              )
              .stroke(.gray300, lineWidth: 0.5)
            }
            .shadow(color: .black.opacity(0.1), radius: 2, x: -2, y: 2)

          Text(time)
            .caption2RegularStyle
            .foregroundStyle(.gray300)
            .offset(y: 1.57)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

#Preview {
  VStack(spacing: 44) {
    ChatMessageView(
      nickname: "조용한 두루미",
      message: "모든 것이 하나로 흐르는 소리 같아요.",
      time: "06:27",
      isMyMessage: false,
      profileImageName: nil
    )
    ChatMessageView(
      nickname: "",
      message: "저는 '쉼'이라는 단어가 떠올랐어요.",
      time: "06:27",
      isMyMessage: true,
      profileImageName: nil
    )
    ChatMessageView(
      nickname: "밤의 사슴",
      message: "저는 강을 다시 읽고 싶어졌어요.",
      time: "06:27",
      isMyMessage: false,
      profileImageName: nil
    )
    ChatMessageView(
      nickname: "새벽 고양이",
      message: "저도 강을 다시 읽고 싶어졌어요.",
      time: "06:27",
      isMyMessage: false,
      profileImageName: nil
    )
  }
  .padding()
  .background(.gray50)
}
