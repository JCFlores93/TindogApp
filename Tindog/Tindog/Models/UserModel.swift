//
//  UserModel.swift
//  Tindog
//
//  Created by jean on 3/25/18.
//  Copyright © 2018 jean. All rights reserved.
//

import Foundation
import Firebase

struct UserModel {
    let uid:String
    let email: String
    let provider: String
    let profileImage: String
    let displayName: String
    let userIsOnMatch: Bool
    init?(snapshot: DataSnapshot){
        let uid = snapshot.key
        guard let dic = snapshot.value as? [String:Any],
            let email = dic["email"] as? String,
            let provider = dic["provider"] as? String,
            let profileImage = dic["provider"] as? String,
            let displayName = dic["provider"] as? String,
        let userIsOnMatch = dic["userIsOnMatch"] as? Bool
            else {return nil}
        self.uid = uid
        self.email = email
        self.provider = provider
        self.profileImage = profileImage
        self.displayName = displayName
        self.userIsOnMatch = userIsOnMatch
    }
}
