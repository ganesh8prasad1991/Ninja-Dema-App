//
//  Date+.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import Foundation



extension Date {
    
    func getCurrentDateTime() -> String {
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy HH:mm")
        return formatter.string(from: self)
    }
}
