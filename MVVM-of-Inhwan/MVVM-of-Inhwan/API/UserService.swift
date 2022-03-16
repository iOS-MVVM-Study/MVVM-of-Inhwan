//
//  UserService.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/03/10.
//

import Firebase

struct UserService {
    static func fetchUser() async -> User? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        do {
            let snapshot = try await COLLECTION_USERS.document(uid).getDocument()
            guard let dictionary = snapshot.data() else { return nil }
            return User(dictionary: dictionary)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func fetchUsers() async -> [User]? {
        do {
            let snapshot = try await COLLECTION_USERS.getDocuments()
            return snapshot.documents.map { User(dictionary: $0.data()) }
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:])
        try await COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:])
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        try await COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete()
        try await COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete()
    }
    
    static func checkIfUserisFollowed(uid: String) async throws -> Bool? {
        guard let currentUid = Auth.auth().currentUser?.uid else { return nil }
        let snapshot = try await COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument()
        let isFollowed = snapshot.exists
        return isFollowed
    }
}
