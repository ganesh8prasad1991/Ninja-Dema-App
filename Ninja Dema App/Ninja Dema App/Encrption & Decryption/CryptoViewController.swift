//
//  CryptoViewController.swift
//  Ninja Dema App
//
//  Created by Ramniwas Patidar(Xebia) on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


class CryptoViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func setup() {
        showNavBar()
    }
    
}
