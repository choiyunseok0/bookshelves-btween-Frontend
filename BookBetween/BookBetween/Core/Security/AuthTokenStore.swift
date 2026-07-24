//
//  AuthTokenStore.swift
//  BookBetween
//

import Foundation

nonisolated protocol AuthTokenStoreProtocol {
    func replaceWithSession(
        accessToken: String,
        refreshToken: String
    ) throws
    func replaceWithRestoreToken(_ restoreToken: String) throws

    func accessToken() throws -> String?
    func refreshToken() throws -> String?
    func restoreToken() throws -> String?

    func clearSession() throws
    func clearRestoreToken() throws
    func clearAll() throws
}

nonisolated final class AuthTokenStore: AuthTokenStoreProtocol {
    private enum Key {
        static let accessToken = "auth.accessToken"
        static let refreshToken = "auth.refreshToken"
        static let restoreToken = "auth.restoreToken"
    }

    private let keychainStore: KeychainStoreProtocol

    init(
        keychainStore: KeychainStoreProtocol = KeychainStore()
    ) {
        self.keychainStore = keychainStore
    }

    func replaceWithSession(
        accessToken: String,
        refreshToken: String
    ) throws {
        try keychainStore.save(accessToken, forKey: Key.accessToken)
        try keychainStore.save(refreshToken, forKey: Key.refreshToken)
        try clearRestoreToken()
    }

    func replaceWithRestoreToken(_ restoreToken: String) throws {
        try clearSession()
        try keychainStore.save(restoreToken, forKey: Key.restoreToken)
    }

    func accessToken() throws -> String? {
        try keychainStore.read(forKey: Key.accessToken)
    }

    func refreshToken() throws -> String? {
        try keychainStore.read(forKey: Key.refreshToken)
    }

    func restoreToken() throws -> String? {
        try keychainStore.read(forKey: Key.restoreToken)
    }

    func clearSession() throws {
        try keychainStore.delete(forKey: Key.accessToken)
        try keychainStore.delete(forKey: Key.refreshToken)
    }

    func clearRestoreToken() throws {
        try keychainStore.delete(forKey: Key.restoreToken)
    }

    func clearAll() throws {
        try clearSession()
        try clearRestoreToken()
    }
}
