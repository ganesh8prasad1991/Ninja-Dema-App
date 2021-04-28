//
//  ToDoTableViewController.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


class ToDoViewController: UIViewController {
    
    //MARK: Properties
    private var todoTasks = [TodoModel]()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let floatingButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 40)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(floatingButtonHandler), for: .touchUpInside)
        //        button.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        button.layer.shadowRadius = 3
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 0.9
        button.layer.shadowOffset = CGSize.zero
        button.layer.zPosition = 1
        button.layer.cornerRadius = 40
        button.layer.masksToBounds = true
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 4
        return button
    }()
    
    //MARK: Intializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    private func setupButton() {
        
        view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
        floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -36),
        floatingButton.heightAnchor.constraint(equalToConstant: 80),
        floatingButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    @objc private func floatingButtonHandler() {
        
        let storyboard = UIStoryboard(name: "ToDo", bundle: nil)
        guard let addTodoVC = storyboard.instantiateViewController(withIdentifier: "AddTodoVC") as? AddTodoViewController else {
            fatalError("Not able to load addTask ViewController!!!")
        }
        addTodoVC.dismissHandler = { [weak self]todo in
            self?.todoTasks.append(todo)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        
        present(addTodoVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To-Do".localized
         setupButton()
    }
}


extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? TodoTableViewCell else {
            fatalError("TableViewCell not loaded")
        }
        cell.taskLabel.text = todoTasks[indexPath.row].todo
        cell.dateTimeLabel.text = todoTasks[indexPath.row].dateTime
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            showAlertWithHandler(title: "Delete".localized, message: "Are you sure you want to delete this task?".localized, indexPath: indexPath)
        }
    }
    
    
    func showAlertWithHandler(title: String, message: String, indexPath: IndexPath) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
        
        // add the cancel action to the alertController
        alert.addAction(cancelAction)

        // create an OK action
        let OKAction = UIAlertAction(title: "OK".localized, style: .default) { [weak self](action) in
            // handle response here.
            self?.deleteRow(indexPath: indexPath)
            
        }
        // add the OK action to the alert controller
        alert.addAction(OKAction)
        
        
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteRow(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.todoTasks.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
