//
//   UpdateDB.swift
//  Tindog
//
//  Created by jean on 3/25/18.
//  Copyright © 2018 jean. All rights reserved.
//

import Foundation
import Firebase

class  UpdateDBService {
    static let  instance = UpdateDBService()
    
    func observerMatch(handler: @escaping(_ matchDict: MatchModel?)-> Void){
        DataBaseService.instance.Match_Ref.observe(.value){
            (snapshot) in
            if let matchSnapshot = snapshot.children.allObjects as? [DataSnapshot]{
                if matchSnapshot.count > 0 {
                    for match in matchSnapshot{
                        if match.hasChild("uid2") && match.hasChild("matchIsAccepter"){
                            if let matchDict = MatchModel(snapshot: match){
                                handler(matchDict)
                            }
                        }
                    }
                }else {
                    handler(nil)
                }
            }
        }
    }
    
}
