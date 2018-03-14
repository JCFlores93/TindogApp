//
//  HomeViewController.swift
//  Tindog
//
//  Created by jean on 3/12/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit

class NavigationImageView: UIImageView {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 76, height:39)
    }
}

class HomeViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var homeWrapper: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleView = NavigationImageView()
        titleView.image = UIImage(named: "Actions")
        self.navigationItem.titleView = titleView
        let homeGR = UIPanGestureRecognizer(target: self, action: #selector(cardDragged(gestureRecognizer:)))
        self.cardView.addGestureRecognizer(homeGR)
        
    }
    
    @objc func cardDragged(gestureRecognizer: UIPanGestureRecognizer){
        //print("Drag \(gestureRecognizer.translation(in: view))")
        let cardPoint = gestureRecognizer.translation(in: view)
        self.cardView.center = CGPoint(x: self.view.bounds.width / 2 + cardPoint.x, y: self.view.bounds.height / 2 + cardPoint.y)
        if gestureRecognizer.state == .ended{
            print(self.cardView.center)
            if self.cardView.center.x < (self.view.bounds.width / 2 - 100) {
                print("dislike")
            }
            if self.cardView.center.x < (self.view.bounds.width / 2 + 100) {
                print("Like")
            }
            
            self.cardView.center = CGPoint(x: self.homeWrapper.bounds.width / 2, y: self.homeWrapper.bounds.height / 2 - 30)
        }
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
