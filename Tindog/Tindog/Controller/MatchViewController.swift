//
//  MatchViewController.swift
//  Tindog
//
//  Created by jean on 3/25/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit

class MatchViewController: UIViewController {

    @IBOutlet weak var copyMatchLbl: UILabel!
    
    @IBAction func doneBtnAction(_ sender: Any) {
        
        if let currentMatch = self.currentMatch{
            if currentMatch.matchIsAccepter {
                
            }else {
                DataBaseService.instance.updateFirebaseDBMatch(uid: currentMatch.uid)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    @IBOutlet weak var firstUserMatch: UIImageView!
    
    @IBOutlet weak var secondUserMatch: UIImageView!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var doneBtnAction: UIButton!
    var currentUserProfile: UserModel?
    var currentMatch: MatchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.secondUserMatch.round()
        self.firstUserMatch.round()
        if let match = self.currentMatch{
            if let profile = self.currentUserProfile{
                var secondId:String = ""
                if profile.uid == match.uid{
                    secondId == match.uid2
                    
                }else {
                    secondId = match.uid
                }
                
                DataBaseService.instance.getUserProfile(uid: secondId, handler: {(secondUser) in
                    if let secondUser = secondUser {
                        if profile.uid == match.uid {
                            self.firstUserMatch.sd_setImage(with: URL(string: profile.profileImage), completed: nil)
                            self.secondUserMatch.sd_setImage(with: URL(string: secondUser.profileImage), completed: nil)
                            self.copyMatchLbl.text = "Esperando a \(secondUser.displayName)"
                            self.doneBtn.alpha = 0
                        }else {
                            self.firstUserMatch.sd_setImage(with: URL(string: secondUser.profileImage), completed: nil)
                            self.secondUserMatch.sd_setImage(with: URL(string: profile.profileImage), completed: nil)
                            self.copyMatchLbl.text = "Tu mascota le gusta a \(secondUser.displayName)"
                            self.doneBtn.alpha = 1
                        }
                    }
                })
                self.secondUserMatch.sd_setImage(with: URL(string: profile.profileImage), completed: nil)
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
