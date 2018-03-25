//
//  HomeViewController.swift
//  Tindog
//
//  Created by jean on 3/12/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit
import RevealingSplashView
import Firebase

class NavigationImageView: UIImageView {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height:39)
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var cardProfileImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    @IBOutlet weak var likeimage: UIImageView!
    @IBOutlet weak var nopeimage: UIImageView!
    
    @IBOutlet weak var cardProfileName: UILabel!
    let leftBtn = UIButton(type: .custom)
    var currentUserProfile: UserModel?
    var users = [UserModel]()
    var secondUserUID: String?
    
    let revealingSplashScreen = RevealingSplashView(iconImage: UIImage(named:"splash_icon")!, iconInitialSize: CGSize(width:80, height:80), backgroundColor: UIColor.white)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.revealingSplashScreen)
        self.revealingSplashScreen.animationType = SplashAnimationType.popAndZoomOut
        self.revealingSplashScreen.startAnimation()
        
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecognizer:)))
        self.cardView.addGestureRecognizer(homeGR)
        self.leftBtn.imageView?.contentMode = .scaleAspectFit
        
        let leftBarButton = UIBarButtonItem(customView: self.leftBtn)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if let user = user {
                print("el usuario se inciò correctamente")
            }else {
                //print("\(user)")
            }
        DataBaseService.instance.observeUserProfile{(userDict) in
            self.currentUserProfile = userDict
        }
            self.getUsers()
        }
        
        UpdateDBService.instance.observerMatch{
            (matchDict) in
            
        }
    }
    @objc func goToLogin(sender: UIButton){
        print("push")
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC")
        present(loginViewController, animated: true, completion: nil)
        
    }
    @objc func cardDragged(gestureRecognizer: UIPanGestureRecognizer){
        let cardPoint = gestureRecognizer.translation(in: view)
        self.cardView.center = CGPoint(x: self.view.bounds.width / 2 + cardPoint.x, y: self.view.bounds.height / 2 + cardPoint.y)
        
        let xFromCenter = self.view.bounds.width / 2 - self.cardView.center.x
        var rotate = CGAffineTransform(rotationAngle: xFromCenter / 200)
        let scale = min(100 / abs(xFromCenter), 1)
        var finalTransform = rotate.scaledBy(x: scale, y: scale)
        
        self.cardView.transform = finalTransform
        
        
        
        if gestureRecognizer.state == .ended{
            print(self.cardView.center)
            if self.cardView.center.x < (self.view.bounds.width / 2 - 100) {
                print("dislike")
                self.nopeimage.alpha = min(abs(xFromCenter / 100),1)
                
            }
            if self.cardView.center.x > (self.view.bounds.width / 2 + 100) {
                print("Like")
                self.likeimage.alpha = min(abs(xFromCenter / 100),1)
            }
            
            
            if gestureRecognizer.state == .ended{
                print(self.cardView.center)
                if self.cardView.center.x < (self.view.bounds.width / 2 - 100) {
                    print("dislike")
                   
                    
                }
                if self.cardView.center.x > (self.view.bounds.width / 2 + 100) {
                    print("Like")
                    if let uid2 = self.secondUserUID {
                        DataBaseService.instance.createFirebaseDBMatch(uid: self.currentUserProfile!.uid, uid2: uid2)
                    }
                    
                }
                //updateImage
                if self.users.count > 0 {
                    self.updateImage(uid: self.users[self.random(0..<self.users.count)].uid)
                }
                
            }
                
            
            
            rotate = CGAffineTransform(rotationAngle: 0)
            finalTransform = rotate.scaledBy(x: 1, y: 1)
            self.cardView.transform = finalTransform
            self.nopeimage.alpha = 0
            self.likeimage.alpha = 0
            
            self.cardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2, y: self.homeWrapper.bounds.height / 2 - 30)
        }
    }

    func random(_ range:Range<Int>)->Int{
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func goToProfile(sender: UIButton){
        print("push")
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let profileViewController = storyBoard.instantiateViewController(withIdentifier: "profilevc") as! ProfileViewController
        profileViewController.currentUserProfile = self.currentUserProfile
        //let us manage the back control
        self.navigationController?.pushViewController(profileViewController, animated: true)
        //present(profileViewController, animated: true, completion: nil)
    }
    
    func getUsers() {
        DataBaseService.instance.User_Ref.observeSingleEvent(of: .value) { (snapshot) in
            let usersSnapshot = snapshot.children.flatMap{ UserModel(snapshot: $0 as! DataSnapshot)}
            for user in usersSnapshot{
                print("user: \(user.email)")
                self.users.append(user)
            }
            if self.users.count > 0 {
                self.updateImage(uid: (self.users.first?.uid)!)
            }
        }        
    }
    
    func updateImage(uid: String) {
        DataBaseService.instance.User_Ref.child(uid).observeSingleEvent(of: .value){(snapshot) in
            if let userProfile = UserModel(snapshot: snapshot){
                self.secondUserUID = userProfile.uid
                self.cardProfileImage.sd_setImage(with: URL(string: userProfile.profileImage), completed: nil)
                self.cardProfileName.text = userProfile.displayName
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.leftBtn.setImage(UIImage(named:"login_active"), for: .normal)
            self.leftBtn.removeTarget(nil, action: nil, for: .allEvents)
            self.leftBtn.addTarget(self, action: #selector(goToProfile(sender:)), for: .touchUpInside)
            self.leftBtn.removeTarget(nil, action: nil, for: .allEvents)

        }else {
            self.leftBtn.setImage(UIImage(named:"login"), for: .normal)
            self.leftBtn.addTarget(self, action: #selector(goToLogin(sender:)), for: .touchUpInside)
        }
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
