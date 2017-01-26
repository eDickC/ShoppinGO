//
//  LoginViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 09/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginViewController: UIViewController {
    
    let MyKeychainWrapper = KeychainWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    var context = LAContext()
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var touchIDButton: UIButton!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createInfoLabel: UILabel!

    
    struct LoginIdentifiers {
        static let segueIdentifier = "login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        touchIDButton.isHidden = true
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            touchIDButton.isHidden = false
        }
        
        let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
        
        if hasLogin {
            loginButton.setTitle("Login", for: UIControlState.normal)
            loginButton.tag = loginButtonTag
            createInfoLabel.isHidden = true
        } else {
            loginButton.setTitle("Create", for: UIControlState.normal)
            loginButton.tag = createLoginButtonTag
            createInfoLabel.isHidden = false
        }
        
        // 3.
        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
            username.text = storedUsername as String
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        if (username.text == "" || password.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Foiled Again!", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return;
        }
        
        username.resignFirstResponder()
        password.resignFirstResponder()
        
        if sender.tag == createLoginButtonTag {
            
            let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
            if hasLoginKey == false {
                UserDefaults.standard.setValue(self.username.text, forKey: "username")
            }
            
            MyKeychainWrapper.mySetObject(password.text, forKey:kSecValueData)
            MyKeychainWrapper.writeToKeychain()
            UserDefaults.standard.set(true, forKey: "hasLoginKey")
            UserDefaults.standard.synchronize()
            loginButton.tag = loginButtonTag
            
            performSegue(withIdentifier: LoginIdentifiers.segueIdentifier, sender: self)
        } else if sender.tag == loginButtonTag {
            if checkLogin(username: username.text!, password: password.text!) {
                performSegue(withIdentifier: LoginIdentifiers.segueIdentifier, sender: self)
            } else {
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.alert)
                let okAction = UIAlertAction(title: "Foiled Again!", style: .default, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            }
        }
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == MyKeychainWrapper.myObject(forKey: "v_Data") as? String &&
            username == UserDefaults.standard.value(forKey: "username") as? String {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func touchIDLoginAction() {
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:nil) {
            
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Logging in with Touch ID") {
                                    (success, evaluateError) in
                                    
                                    if (success) {
                                        DispatchQueue.main.async {
                                            // User authenticated successfully, take appropriate action
                                            self.performSegue(withIdentifier: LoginIdentifiers.segueIdentifier, sender: self)
                                        }
                                    } else {
                                        
                                        if let error: LAError = evaluateError as! LAError? {
                                            var message: String
                                            var showAlert : Bool
                                            
                                            switch error {
                                                
                                            case LAError.authenticationFailed:
                                                message = "There was a problem verifying your identity."
                                                showAlert = true
                                            case LAError.userCancel:
                                                message = "You pressed cancel."
                                                showAlert = true
                                            case LAError.userFallback:
                                                message = "You pressed password."
                                                showAlert = true
                                            default:
                                                showAlert = true
                                                message = "Touch ID may not be configured"
                                            }
                                            
                                            if showAlert {
                                                let alertView = UIAlertController(title: "Error",
                                                                                  message: message as String, preferredStyle:.alert)
                                                let okAction = UIAlertAction(title: "Darn!", style: .default, handler: nil)
                                                alertView.addAction(okAction)
                                                self.present(alertView, animated: true, completion: nil)
                                            }
                                        }
                                    }
            }
        } else {
            let alertView = UIAlertController(title: "Error",
                                              message: "Touch ID not available" as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Darn!", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
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
