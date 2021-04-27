//
//  UIViewController +.swift
//  Ninja Dema App
//
//  Created by Ramniwas Patidar(Xebia) on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func showNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func hideNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func pushVC(_ VCName: String, storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: VCName)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
