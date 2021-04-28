//
//  ChangeLanguageViewController.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit



class ChangeLanguageViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    struct LanguageModel {
        let language: String
        let code: String
    }
    
    private let languages = [
        LanguageModel(language: "English", code: "en"),
        LanguageModel(language: "Arabic", code: "ar")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Change Language".localized
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension ChangeLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = languages[indexPath.row].language
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let code = languages[indexPath.item].code
        if code == "en" {
            Language.language = Language.english
        }else {
            Language.language = Language.arabic
        }
        
    }
}
