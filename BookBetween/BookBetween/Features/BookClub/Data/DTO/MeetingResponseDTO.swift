//
//  MeetingResponseDTO.swift
//  BookBetween
//

import Foundation

struct MeetingResultDTO: Decodable {
    let id: Int
    let chatroomId: Int
    let book: MeetingBookDTO
    let startDate: String
    let duration: Int
    let maxParticipants: Int
    let currentParticipants: Int
    let status: String
    let meetingSummary: [MeetingSummaryItemDTO]?
}

struct MeetingBookDTO: Decodable {
    let id: Int?
    let isbn: String?
    let title: String
    let author: String
    let publisher: String?
    let coverImageUrl: String?
    let kdcCode: String?
    let kdcName: String?
}

struct MeetingSummaryItemDTO: Decodable {
    let questionOrder: Int
    let question: String
    let summary: String
}

extension MeetingResultDTO {
    func toDomain() throws -> BookMeeting {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        guard let meetingDate = formatter.date(from: startDate) else {
            throw MeetingDTOError.invalidDate(startDate)
        }

        let statusValue: BookMeetingStatus
        switch status {
        case "RECRUITING": statusValue = .recruiting
        case "UPCOMING", "SCHEDULED": statusValue = .upcoming
        case "COMPLETED", "DONE": statusValue = .completed
        default: statusValue = .upcoming
        }

        return BookMeeting(
            id: id,
            chatroomId: chatroomId,
            book: Book(
                id: book.id,
                isbn: book.isbn,
                title: book.title,
                author: book.author,
                publisher: book.publisher,
                coverImageUrl: book.coverImageUrl,
                kdcCode: book.kdcCode,
                kdcName: book.kdcName
            ),
            meetingDate: meetingDate,
            timerMinutes: duration,
            maxParticipants: maxParticipants,
            currentParticipants: currentParticipants,
            status: statusValue,
            meetingSummary: meetingSummary?.map {
                MeetingSummaryItem(questionOrder: $0.questionOrder, question: $0.question, summary: $0.summary)
            }
        )
    }
}

enum MeetingDTOError: LocalizedError {
    case invalidDate(String)

    var errorDescription: String? {
        switch self {
        case .invalidDate:
            return "모임 응답의 날짜 형식이 올바르지 않습니다."
        }
    }
}
