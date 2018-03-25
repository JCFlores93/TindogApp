//
//  MatchModel.swift
//  Tindog
//
//  Created by jean on 3/25/18.
//  Copyright © 2018 jean. All rights reserved.
//

import Foundation
import Firebase

struct MatchModel{
    let uid: String
    let uid2: String
    let matchIsAccepter: Bool
    
    init?(snapshot: DataSnapshot){
        let uid = snapshot.key
        guard let dic = snapshot.value as? [String:Any],
        let uid2 = dic["uid2"] as? String,
            let matchIsAccepter = dic["matchIsAccepter"] as? Bool else {
                return nil
        }
        self.uid = uid
        self.uid2 = uid2
        self.matchIsAccepter = matchIsAccepter
    }
}
