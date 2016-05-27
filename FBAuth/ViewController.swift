//
//  ViewController.swift
//  FBAuth
//
//  Created by William Quan on 5/27/16.
//  Copyright © 2016 William Quan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase


class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = CGPointMake( self.view.bounds.size.width / 2,
                                          3 * self.view.bounds.size.height / 4);
        self.view.addSubview(loginButton)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        self.performSegueWithIdentifier("next", sender: self)

        if let error = error {
            print(error.localizedDescription)
            return
        }

        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            // ...
        }

        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        try! FIRAuth.auth()!.signOut()
    }
    


}

