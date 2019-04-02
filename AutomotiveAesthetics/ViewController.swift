//
//  ViewController.swift
//  AutomotiveAesthetics
//
//  Created by Kevin Rama on 3/6/19.
//  Copyright © 2019 Kevin Rama. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: GIDSignInButton!
    var google = false;
    
    @IBAction func googleAction(_ sender: GIDSignInButton) {
        signInWithGoogle();
    }
    
    
    @IBAction func inputAction(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if(emailTextField.text != "" && passwordTextField.text != ""){
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
                if error != nil {
                    //Error
                    
                    let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert);
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
                    self.present(alert, animated: true, completion: nil)
                    print(error?.localizedDescription as Any);
                    return
                    
                }
                self.performSegue(withIdentifier: "segue1", sender: nil);
            })
        }
        else {
            let alert = UIAlertController(title: "Input Error", message: "Fill In Email and Password", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert, animated: true, completion: nil);
        } 
        
    }

    
    @IBAction func registerFunc(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
    
    
    fileprivate func signInWithGoogle(){
        GIDSignIn.sharedInstance()?.uiDelegate = self;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInWithGoogle();
        /* // Do any additional setup after loading the view, typically from a nib.*/
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        if (Auth.auth().currentUser != nil) || (GIDSignIn.sharedInstance()?.currentUser) != nil {
            self.performSegue(withIdentifier: "segue1", sender: nil);
        }
    }


}

