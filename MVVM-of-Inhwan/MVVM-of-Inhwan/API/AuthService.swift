//
//  AuthService.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/23.
//

import Foundation
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credentials: AuthCredentials) {
        print("DEBUG: Credentials are \(credentials)")
    }
    
}
