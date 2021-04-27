//
//  AppDelegate.swift
//  Ninja Dema App
//
//  Created by Ramniwas Patidar(Xebia) on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let kClientId = "255386900201-5c6fh28ebghoob16m1mdb7oc3f1qbq2j.apps.googleusercontent.com"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GIDSignIn.sharedInstance()?.clientID = kClientId
        
        checkLoginStatus()
        return true
    }

    
    private func checkLoginStatus() {
        
        let loginStatus = GIDSignIn.sharedInstance()?.hasPreviousSignIn() ?? false
        if loginStatus {
            createViewConytroller("Crypto", vcName: "CryptoVC")
        }else {
            createViewConytroller("Login", vcName: "LoginVC")
        }
    }
    
    
    private func createViewConytroller(_ storyboardName: String, vcName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: vcName)
        
        let navController = UINavigationController(rootViewController: loginViewController)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        self.window?.rootViewController = navController
    }
    
    
    //MARK: Google Signin callback
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance()?.handle(url) ?? false
    }

}

