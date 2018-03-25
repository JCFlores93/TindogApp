//
//  ProfileViewController.swift
//  Tindog
//
//  Created by jean on 3/24/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileDisplaynamelbl: UILabel!
    @IBOutlet weak var profileEmaillbl: UILabel!
    var currentUserProfile: UserModel?
    
    
    @IBAction func vloseProfileBtn(_ sender: Any){
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.profileImage.sd_setImage(with: URL(string: (self.currentUserProfile?.profileImage)!), completed: nil)
        //Round images
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.layer.borderColor = UIColor.white.cgColor
        self.profileImage.layer.borderWidth = 1.0
        self.profileImage.clipsToBounds = true
        
        self.profileEmaillbl.text = self.currentUserProfile?.email
        self.profileDisplaynamelbl.text = self.currentUserProfile?.displayName
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

    @IBAction func importUsersAction(_ sender: Any) {
        let users = [["email":"crispeta@platzi.com","password":"123456","displayName":"Jean","photoURL":"https://i.imgur.com/YYqOgZB.jpg"],
                     ["email":"bublie@platzi.com","password":"123456","displayName":"bublie","photoURL":"https://i.imgur.com/rmBXzbv.jpg"],
                     ["email":"tony@platzi.com","password":"123456","displayName":"Tony","photoURL":"https://i.imgur.com/piEDB2T.jpg"],
                     ["email":"nalia@platzi.com","password":"123456","displayName":"nalia","photoURL":"https://i.imgur.com/gCclkXK.jpg"],
                     ["email":"chipotle@platzi.com","password":"123456","displayName":"Chipotle","photoURL":"https://i.imgur.com/ocNYvgJ.jpg"]]
        
        for userDemo in users {
            Auth.auth().createUser(withEmail: userDemo["email"]!, password: userDemo["password"]!, completion: {(user, error) in
                if let user = user {
                    let userData = ["provider":user.providerID, "email": user.email!,"profileImage": userDemo["photoURL"]!, "displayName": userDemo["displayName"]!, "userIsOnMatch": false] as [String: Any]
                    DataBaseService.instance.createFirebaseDBUser(uid: user.uid, userData: userData)
                }
            })
        }
    }
}
