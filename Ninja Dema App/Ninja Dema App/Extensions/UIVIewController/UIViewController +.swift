//
//  UIViewController +.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func showNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func pushVC(_ VCName: String, storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: VCName)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func present(_ VCName: String, storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: VCName)
        
        present(viewController, animated: true
            , completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        present(alert, animated: true, completion: nil)
    }
    
    
    func createViewConytroller(_ storyboardName: String, vcName: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: vcName)
    }
}
