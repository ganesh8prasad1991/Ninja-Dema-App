//
//  AddTodoViewController.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


class AddTodoViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet private weak var addTaskTextField: UITextField!
    @IBOutlet private weak var addTaskDateTimeTextField: DateTimeTextField!
    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    
    var dismissHandler : ( (TodoModel)->() )?
    
    //MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        addTaskTextField.placeholder = "Task Name".localized
        addTaskDateTimeTextField.placeholder = "Date and time".localized
        clearButton.setTitle("Clear".localized, for: .normal)
        saveButton.setTitle("Save".localized, for: .normal)
    }
    
    
    //MARK: IBActions
    @IBAction private func clearButtonHandler(_ sender: UIButton) {
        addTaskTextField.text = ""
        addTaskDateTimeTextField.text = ""
    }
    
    @IBAction private func saveButtonHandler(_ sender: UIButton) {
        guard let task = addTaskTextField.text,
            let dateTime = addTaskDateTimeTextField.text,
            task.count > 0,
            dateTime.count > 0 else {
                return
        }
        
        let todo = TodoModel(todo: addTaskTextField.text ?? "",
                             dateTime: addTaskDateTimeTextField.text ?? ""
        )
        
        dismissHandler?(todo)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @objc private func handleTap() {
        self.view.endEditing(true)
    }
}
