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
    
    var dismissHandler : ( (TodoModel)->() )?
    
    //MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
    }
    
    
    //MARK: IBActions
    @IBAction private func clearButtonHandler(_ sender: UIButton) {
        addTaskTextField.text = ""
        addTaskDateTimeTextField.text = ""
    }
    
    @IBAction private func saveButtonHandler(_ sender: UIButton) {
        if validate() {
            
            let todo = TodoModel(todo: addTaskTextField.text ?? "",
                                 dateTime: addTaskDateTimeTextField.text ?? ""
            )
            
            dismissHandler?(todo)
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func validate() -> Bool {
        guard let task = addTaskTextField.text,
            let dateTime = addTaskDateTimeTextField.text else {
                return false
        }
        
        
        if task.count == 0 {
            showAlert(title: "Add Todo", message: "Please enter Task")
            return false
        }else if dateTime.count == 0 {
            showAlert(title: "Add Todo", message: "Please enter Task's time")
            return false
        }
        
        return true
    }
    

    
    @objc private func handleTap() {
        self.view.endEditing(true)
    }
}
