//
//  MySideMenu.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case cryto = "Encryption"
    case todo = "To-Do"
    case stopwatch = "Stopwatch"
    case changeLanguage = "Change Language"
    case logout = "Logout"
}

class MySideMenuController: UITableViewController {

    public var delegate: MenuControllerDelegate?

    private let menuItems: [SideMenuItem]
    private let color = UIColor(red: 33/255.0,
                                green: 33/255.0,
                                blue: 33/255.0,
                                alpha: 1)

    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
    }

    // Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue.localized
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        cell.contentView.backgroundColor = color
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Relay to delegate about menu item selection
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }

}
