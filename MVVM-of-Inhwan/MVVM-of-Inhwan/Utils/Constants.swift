//
//  Constants.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/03/10.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
