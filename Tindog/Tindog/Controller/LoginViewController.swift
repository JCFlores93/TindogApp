//
//  LoginViewController.swift
//  Tindog
//
//  Created by jean on 3/17/18.
//  Copyright © 2018 jean. All rights reserved.
//

import UIKit
import Firebase

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
    func showAlert(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    @IBAction func loginActionBtn(_ sender: Any) {
        if (self.emailTextField.text == "" || self.passwordTextField.text == "") {
            self.showAlert(title: "Error", message: "Algunos de los campos està vacìo")
        }else {
            if let email = self.emailTextField.text {
                if let pwd = self.passwordTextField.text {
                    if registerMode {
                        Auth.auth().createUser(withEmail: email, password: pwd, completion: {(user, error) in
                            if error != nil {
                                self.showAlert(title: "Error", message: error!.localizedDescription)
                            }else {
                                print("Login")
                            }
                        })
                    }else {
                        
                    }
                }
            }
        }
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
