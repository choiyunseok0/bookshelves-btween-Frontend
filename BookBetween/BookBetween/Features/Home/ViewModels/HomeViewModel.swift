//
//  HomeViewModel.swift
//  BookBetween
//
//  Created by 이준성 on 7/2/26.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    var home: Home

    private let meetingsPageSize = 3
    private var currentMeetingsPage = 1
    var isLoadingMoreMeetings = false
    var hasMoreMeetings = true

    init() {
        self.home = Home(
            user: User(id: "1", nickname: "책 먹는 여우", profileImageURL: nil),
            dailyRecommendation: DailyBookRecommendation(
                book: Book(
                    id: 1,
                    title: "랑과 나의 사막",
                    author: "천선란",
                    description: nil
                ),
                description: "멸망한 세계의 어느날 나의 주인이 죽었다"
            ),
            recentBooks: [
                UserBookRecord(
                    id: 1,
                    book: Book(
                        id: 2,
                        title: "아무 희미한 빛으로도",
                        author: "최은영",
                        description: nil
                    ),
                    progress: 75,
                    rating: 4.5,
                    memo: nil
                )
            ],
            recruitingMeetings: [
                BookMeeting(
                    id: "meeting-1",
                    book: Book(
                        id: 3,
                        title: "빛은 얼마나 깊이 스미는가",
                        author: "",
                        description: nil
                    ),
                    title: nil,
                    description: "",
                    recruitmentStartDate: Date(),
                    recruitmentEndDate: Date(),
                    readingStartDate: Date(),
                    readingEndDate: Date(),
                    meetingDate: Date(),
                    timerMinutes: 60,
                    maxParticipants: 6,
                    currentParticipants: 2,
                    status: .recruiting
                ),
                BookMeeting(
                    id: "meeting-2",
                    book: Book(
                        id: 4,
                        title: "프로젝트 헤일미리",
                        author: "",
                        description: nil
                    ),
                    title: nil,
                    description: "",
                    recruitmentStartDate: Date(),
                    recruitmentEndDate: Date(),
                    readingStartDate: Date(),
                    readingEndDate: Date(),
                    meetingDate: Date(),
                    timerMinutes: 60,
                    maxParticipants: 6,
                    currentParticipants: 2,
                    status: .recruiting
                )
            ]
        )
    }

    /// 무한 스크롤 트리거: 마지막에서 가까운 카드가 나타나면 다음 페이지를 불러옴.
    func loadMoreMeetingsIfNeeded(currentItem: BookMeeting) {
        guard !isLoadingMoreMeetings, hasMoreMeetings else { return }
        let thresholdIndex = home.recruitingMeetings.index(
            home.recruitingMeetings.endIndex, offsetBy: -1
        )
        guard let currentIndex = home.recruitingMeetings.firstIndex(where: { $0.id == currentItem.id }),
              currentIndex == thresholdIndex else { return }
        loadMoreMeetings()
    }

    private func loadMoreMeetings() {
        isLoadingMoreMeetings = true
        Task {
            // TODO: 추후 API 연동 시 아래를 실제 네트워크 호출로 교체 예정
            // let page = try await meetingService.fetchRecruitingMeetings(page: currentMeetingsPage, size: meetingsPageSize)
            // home.recruitingMeetings.append(contentsOf: page.items)
            // hasMoreMeetings = page.hasNext
            hasMoreMeetings = false // 목데이터 소진 - 실제 API 붙이면 서버 응답의 hasNext로 대체
            currentMeetingsPage += 1
            isLoadingMoreMeetings = false
        }
    }
}
