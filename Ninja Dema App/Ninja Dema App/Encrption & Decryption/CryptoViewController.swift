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
        
        
        print(String(bytes: xorEncryption("Hello", encryptedKey: "World"), encoding: .utf8))
        print(xorDecryption(xorEncryption("Hello", encryptedKey: "World"), decodingKey: "World"))
    }
    
    
    private func setup() {
        showNavBar()
    }
    
    
    private func convertEncryptedDatatoString(_ encrptedData: [UInt8]) -> String {
        return String(bytes: encrptedData, encoding: .utf8) ?? ""
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
