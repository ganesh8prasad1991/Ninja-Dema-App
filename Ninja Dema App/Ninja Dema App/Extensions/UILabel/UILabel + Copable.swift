//
//  UILabel + Copable.swift
//  Ninja Dema App
//
//  Created by Ganesh Prasad on 28/04/21.
//  Copyright © 2021 Ninja Dema App. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC


private var is_copyEnabled = false

extension UILabel {

var isCopyEnabled: Bool {
    get{
        return objc_getAssociatedObject(self, &is_copyEnabled) as! Bool
    }
    set{
        objc_setAssociatedObject(self, &is_copyEnabled, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        attachTapHandler()
    }
}

open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return action == #selector(UILabel.copyText(sender:))
}

func attachTapHandler() {
    self.isUserInteractionEnabled = true
    let longPress = UILongPressGestureRecognizer(target: self, action: #selector(UILabel.handleTap(ges:)))
    self.addGestureRecognizer(longPress)
}

@objc fileprivate func handleTap(ges: UIGestureRecognizer) {
    if ges.state == .began {
        becomeFirstResponder()
                     let item = UIMenuItem(title: "copy", action: #selector(UILabel.copyText(sender:)))
        UIMenuController.shared.menuItems = [item]
                     // Calculate the label real frame, let the copy display in the middle
        let rect = (text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height:self.bounds.size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font ?? UIFont()], context: nil)
        let width = rect.size.width > self.bounds.size.width ? self.bounds.size.width : rect.size.width
        let frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: width, height: self.frame.size.height)
        UIMenuController.shared.setTargetRect(frame, in: self.superview!)
        UIMenuController.shared.setMenuVisible(true, animated: true)
    }
    
}

@objc fileprivate func copyText(sender: Any) {
             //Universal pasteboard
    let pBoard = UIPasteboard.general
    
             // Sometimes just want to take a part of the UILabel text
    if objc_getAssociatedObject(self, "expectedText") != nil {
        pBoard.string = objc_getAssociatedObject(self, "expectedText") as! String?
    } else {
        if self.text != nil {
            pBoard.string = self.text
        } else {
            pBoard.string = self.attributedText?.string
        }
    }
}

open override var canBecomeFirstResponder: Bool{
    return isCopyEnabled
}
}


