//
//  File.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/03/10.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)    }
    
    init(user: User) {
        self.user = user
    }
}
