//
//  ViewController.swift
//  loginFacebook
//
//  Created by Kien on 5/1/19.
//  Copyright © 2019 Kien. All rights reserved.
//
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        

        loginButton.delegate = self as! FBSDKLoginButtonDelegate
        if (FBSDKAccessToken.current() != nil) {
            // User is logged in, do work such as go to next view controller.
        }
    }
    
    
    


}
extension ViewController:FBSDKLoginButtonDelegate{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error{
            print(error.localizedDescription)
            return
        }
//        let credential = .credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {

            
    }
    
    @IBAction func facebookLogin(sender: AnyObject) {
        let LoginManager = FBSDKLoginManager()
        LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
            }
        }
    }
//    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//    if let error = error {
//    // ...
//    return
//    }
//
//    let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//    // User is signed in
//    // ...
//    }
    
    
    
}

