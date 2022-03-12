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
}
