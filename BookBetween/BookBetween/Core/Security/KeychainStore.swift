//
//  KeychainStore.swift
//  BookBetween
//

import Foundation
import Security

nonisolated protocol KeychainStoreProtocol {
    func save(_ value: String, forKey key: String) throws
    func read(forKey key: String) throws -> String?
    func delete(forKey key: String) throws
}

nonisolated final class KeychainStore: KeychainStoreProtocol {
    private let service: String

    init(
        service: String = Bundle.main.bundleIdentifier ?? "BookBetween"
    ) {
        self.service = service
    }

    func save(_ value: String, forKey key: String) throws {
        guard let data = value.data(using: .utf8) else {
            throw KeychainStoreError.encodingFailed
        }

        let query = baseQuery(forKey: key)
        let updateStatus = SecItemUpdate(
            query as CFDictionary,
            [kSecValueData as String: data] as CFDictionary
        )

        switch updateStatus {
        case errSecSuccess:
            return

        case errSecItemNotFound:
            var attributes = query
            attributes[kSecValueData as String] = data
            attributes[kSecAttrAccessible as String] =
                kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly

            let addStatus = SecItemAdd(
                attributes as CFDictionary,
                nil
            )

            guard addStatus == errSecSuccess else {
                throw KeychainStoreError.unexpectedStatus(addStatus)
            }

        default:
            throw KeychainStoreError.unexpectedStatus(updateStatus)
        }
    }

    func read(forKey key: String) throws -> String? {
        var query = baseQuery(forKey: key)
        query[kSecReturnData as String] = true
        query[kSecMatchLimit as String] = kSecMatchLimitOne

        var result: CFTypeRef?
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &result
        )

        switch status {
        case errSecSuccess:
            guard let data = result as? Data,
                  let value = String(data: data, encoding: .utf8) else {
                throw KeychainStoreError.decodingFailed
            }

            return value

        case errSecItemNotFound:
            return nil

        default:
            throw KeychainStoreError.unexpectedStatus(status)
        }
    }

    func delete(forKey key: String) throws {
        let status = SecItemDelete(
            baseQuery(forKey: key) as CFDictionary
        )

        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainStoreError.unexpectedStatus(status)
        }
    }

    private func baseQuery(forKey key: String) -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecAttrSynchronizable as String: kCFBooleanFalse as Any
        ]
    }
}

nonisolated enum KeychainStoreError: LocalizedError {
    case encodingFailed
    case decodingFailed
    case unexpectedStatus(OSStatus)

    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return "Keychain에 저장할 값을 변환하지 못했습니다."

        case .decodingFailed:
            return "Keychain에서 읽은 값을 변환하지 못했습니다."

        case .unexpectedStatus(let status):
            let message = SecCopyErrorMessageString(status, nil) as String?
            return message ?? "Keychain 오류가 발생했습니다. (\(status))"
        }
    }
}
