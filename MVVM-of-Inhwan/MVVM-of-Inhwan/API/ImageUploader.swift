//
//  ImageUploader.swift
//  MVVM-of-Inhwan
//
//  Created by 김인환 on 2022/02/23.
//

import UIKit
import Firebase
import FirebaseStorageSwift

struct ImageUploader {
    //    static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
    //        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
    //
    //        let filename = NSUUID().uuidString
    //        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
    //
    //        ref.putData(imageData, metadata: nil) { metadata, error in
    //            if let error = error {
    //                print("DEBUG: Failed to upload image \(error.localizedDescription)")
    //                return
    //            }
    //
    //            ref.downloadURL { (url, error) in
    //                guard let imageUrl = url?.absoluteString else { return }
    //                completion(imageUrl)
    //            }
    //        }
    //    }
    
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return nil }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        let _ = try await ref.putDataAsync(imageData, metadata: nil)
        return try await ref.downloadURL().absoluteString
    }
}
