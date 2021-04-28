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
    
    private let languages = [
        "English",
        "Arabic"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension ChangeLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = languages[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
