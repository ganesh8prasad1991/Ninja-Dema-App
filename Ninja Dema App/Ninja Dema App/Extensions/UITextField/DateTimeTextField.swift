//
//  DateTimeTextField.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import UIKit


class DateTimeTextField: UITextField {
    
    var date : Date {
        set {
           picker.date = newValue
            text = newValue.getCurrentDateTime()
        }

        get {
            return picker.date
        }
    }
    
    
    //public handlers
    var didChange : ( (Date)->() )?
    var didSelect : ( (Date)->() )?
    
    private var picker : UIDatePicker {
        return inputView as! UIDatePicker
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        
        //picker for datefield
        inputView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        picker.datePickerMode = .dateAndTime
        picker.addTarget(self, action: #selector(pickerChanged), for: .valueChanged)
        let toolBar = UIToolbar()
        toolBar.tintColor = .blue
        
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didPressDone))
        ]
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
    
    @objc private func pickerChanged() {
        text = date.getCurrentDateTime()
        didChange?(picker.date)
    }

    @objc private func didPressDone() {
        text = date.getCurrentDateTime()
        resignFirstResponder()
        didSelect?(picker.date)
    }
    
    
    
}
