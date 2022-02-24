//
//  AuthService.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/23.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials) async throws {
//        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
//            dump(imageUrl)
//            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { results, error in
//                if let error = error {
//                    print("DEBUG: Failed to register user \(error.localizedDescription)")
//                    return
//                }
//
//                guard let uid = results?.user.uid else { return }
//
//                let data: [String: Any] = ["email": credentials.email,
//                                           "fullname": credentials.fullname,
//                                           "profileImageUrl": imageUrl,
//                                           "uid": uid,
//                                           "username": credentials.username]
//
//                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
//            }
//        }
        guard let imageUrl = try await ImageUploader.uploadImage(image: credentials.profileImage) else { return }
        
        let result = try await Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
        let uid = result.user.uid
        let data: [String: Any] = ["email": credentials.email,
                                    "fullname": credentials.fullname,
                                    "profileImageUrl": imageUrl,
                                    "uid": uid,
                                    "username": credentials.username]
        
        try await Firestore.firestore().collection("users").document(uid).setData(data)
    }
    
}
