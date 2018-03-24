//
//  LoginViewController.swift
//  Tindog
//
//  Created by jean on 3/17/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var subLoginBtn: UIButton!
    @IBOutlet weak var loginCopyLabel: UILabel!
    
    var registerMode = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.bindKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    @IBAction func subLoginAction(_ sender: Any) {
        if self.registerMode {
            self.loginBtn.setTitle("Login", for: .normal)
            self.loginCopyLabel.text = "Eres Nuevo?"
            self.subLoginBtn.setTitle("Registrate", for: .normal)
            self.registerMode = false
        }else {
            self.loginBtn.setTitle("Crear Cuenta", for: .normal)
            self.loginCopyLabel.text = "Ya tienes cuenta"
            self.subLoginBtn.setTitle("Login", for: .normal)
            self.registerMode = true
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var loginActionBtn: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
