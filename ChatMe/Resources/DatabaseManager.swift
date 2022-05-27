//
//  DatabaseManager.swift
//  ChatMe
//
//  Created by Coding on 5/26/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let userInfo = DatabaseManager()
    private let databese = Database.database().reference()
}

// Mark: - User Management

extension DatabaseManager {
    
    /// Create new user in database
    public func createUserInDatabase(with user: ChatMeUser) {
        databese.child(user.firebaseEmailFormat).setValue([
            "country": user.country
//            "profile_image":
        ])
    }
    
    /// Check if user exist
    public func isUserExist(with userEmail: String,
                            completion: @escaping ((Bool) -> Void)) {
        
        var formattedEmail = userEmail.replacingOccurrences(of: ".", with: "")
        formattedEmail = formattedEmail.replacingOccurrences(of: "@", with: "")
        
        databese.child(formattedEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
}

struct ChatMeUser {
    let emailAddress: String
    let country: String
//    let profileImageLocation: String
    
    //Firebase can't accept "." and "@". So, we need to replace the email address
    var firebaseEmailFormat: String {
        var email = emailAddress.replacingOccurrences(of: ".", with: "")
        email = email.replacingOccurrences(of: "@", with: "")
        return email
    }
}
