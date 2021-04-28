//
//  CryptoViewController.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 27/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit
import GoogleSignIn


class CryptoViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak private var normalText: UITextField!
    @IBOutlet weak private var secretKey: UITextField!
    
    @IBOutlet weak private var encryptedLabel: UILabel! {
        didSet {
            encryptedLabel.isCopyEnabled = true
        }
    }
    @IBOutlet weak private var decryptedLabel: UILabel! {
        didSet {
            decryptedLabel.isCopyEnabled = true
        }
    }
    
    private var sideMenu: SideMenuNavigationController?
    //ViewControllers for references
    
    private var todoController: ToDoViewController!
    private var stopwatchController: StopwatchViewController!
    private var changeLanguageController:ChangeLanguageViewController!
    
    private func setup() {
        showNavBar()
        title = "Crypto"
        
        let menu = MySideMenuController(with: SideMenuItem.allCases)

        menu.delegate = self

        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true

        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)

        addChildControllers()
    }
    
    
    private func addChildControllers() {
        
        todoController = createViewConytroller("ToDo", vcName: "ToDoVC") as? ToDoViewController
        stopwatchController = createViewConytroller("Stopwatch", vcName: "StopwatchVC") as? StopwatchViewController
        changeLanguageController = createViewConytroller("ChangeLanguage", vcName: "ChangeLanguageVC") as? ChangeLanguageViewController
        
        addChild(todoController)
        addChild(stopwatchController)
        addChild(changeLanguageController)

        view.addSubview(todoController.view)
        view.addSubview(stopwatchController.view)
        view.addSubview(changeLanguageController.view)
        
        todoController.view.frame = view.bounds
        stopwatchController.view.frame = view.bounds
        changeLanguageController.view.frame = view.bounds

        todoController.didMove(toParent: self)
        stopwatchController.didMove(toParent: self)
        changeLanguageController.didMove(toParent: self)

        todoController.view.isHidden = true
        stopwatchController.view.isHidden = true
        changeLanguageController.view.isHidden = true
    }
    
    
    //MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    //MARK: @IBActions
    @IBAction private func encryptHandler(_ sender: UIButton) {
        
        guard let normalText = normalText.text,
            let key = secretKey.text,
            normalText.count > 0,
            key.count > 0 else {
            return
        }
            
        let encrypt = xorEncryption(normalText, encryptedKey: key)
        encryptedLabel.text = convertEncryptedDatatoString(encrypt)
    }
    
    
    @IBAction private func decryptHandler(_ sender: UIButton) {
        guard let normalText = normalText.text,
            let key = secretKey.text,
            normalText.count > 0,
            key.count > 0 else {
            return
        }
            
        let encrypt = xorEncryption(normalText, encryptedKey: key)
        let decrpt = xorDecryption(encrypt, decodingKey: key)
        decryptedLabel.text = decrpt
    }
    
    
    @IBAction func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    //MARK: Encryption/Decryption Logic
    private func convertEncryptedDatatoString(_ encrptedData: [UInt8]) -> String {
        var hexString = ""
        for byte in encrptedData {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    private func xorEncryption(_ message: String, encryptedKey: String) -> [UInt8] {
        
        if message.count == 0 { return [UInt8]() }
        
        var encrypted = [UInt8]()
        let text = [UInt8](message.utf8)
        let key = [UInt8](encryptedKey.utf8)
        let length = key.count
        
        
        // encrypt bytes
        for t in text.enumerated() {
            encrypted.append(t.element ^ key[t.offset % length])
        }
        
        return encrypted
    }
    
    
    private func xorDecryption(_ cyperText: [UInt8], decodingKey: String) -> String {
        
        if cyperText.count == 0 {return ""}
        
        var decrypted = [UInt8]()
        let cyper = cyperText
        let key = [UInt8](decodingKey.utf8)
        let length = key.count
        
        // decrypt bytes
        for t in cyper.enumerated() {
            decrypted.append(t.element ^ key[t.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8) ?? ""
    }
    
    
}



extension CryptoViewController: MenuControllerDelegate {
    
    func didSelectMenuItem(named: SideMenuItem) {
            sideMenu?.dismiss(animated: true, completion: nil)

            title = named.rawValue
            switch named {
            case .cryto:
                todoController.view.isHidden = true
                stopwatchController.view.isHidden = true
                changeLanguageController.view.isHidden = true
                break

            case .todo:
                todoController.view.isHidden = false
                stopwatchController.view.isHidden = true
                changeLanguageController.view.isHidden = true
                break

            case .stopwatch:
                todoController.view.isHidden = true
                stopwatchController.view.isHidden = false
                changeLanguageController.view.isHidden = true
                break
            case .logout:
                logOut()
                break
            case .changeLanguage:
                todoController.view.isHidden = true
                stopwatchController.view.isHidden = true
                changeLanguageController.view.isHidden = false
                break
                
            }

        }
    
    
    
    private func logOut() {
        
        GIDSignIn.sharedInstance()?.signOut()
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        
        let navController = UINavigationController(rootViewController: viewController)
        
        self.view.window?.rootViewController = navController
        
    }
}
