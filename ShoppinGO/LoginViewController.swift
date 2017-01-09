//
//  LoginViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 09/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let storedUsername = "edo"
    let storedPassword = "edo"

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    struct LoginIdentifiers {
        static let segueIdentifier = "login"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login() {
        if username.text == storedUsername && password.text == storedPassword {
            performSegue(withIdentifier: LoginIdentifiers.segueIdentifier, sender: nil)
        } else  {
            username.shake()
            password.shake()
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
