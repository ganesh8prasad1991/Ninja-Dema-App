//
//  LoginViewController.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit
import GoogleSignIn


class LoginViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let signIn = GIDSignIn.sharedInstance()
        signIn?.delegate = self
        signIn?.presentingViewController = self

        hideNavBar()
    }
    
    //MARK: Outlets
    @IBAction private func signInButtonHandler(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
}



extension LoginViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Unable to login: \(err.localizedDescription)")
            return
        }
        
        let storyboard = UIStoryboard(name: "Crypto", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CryptoVC"
        )
        let menu = SideMenuNavigationController(rootViewController: viewController)
        self.view.window?.makeKeyAndVisible()
        self.view.window?.rootViewController = menu
        
    }
}
