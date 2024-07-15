//
//  KeyboardManager.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/11/24.
//

import Foundation
import UIKit

class KeyboardManager {
    
    private var willShowObserver: NSObjectProtocol?
    private var willHideObserver: NSObjectProtocol?
    
    var onKeyboardWillShow: ((CGFloat) -> Void)?
    var onKeyboardWillHide: (() -> Void)?
    
    init() {
        willShowObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main,
            using: { [weak self] notification in
            self?.keyboardWillShow(notification: notification)
        })
        
        willHideObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main,
            using: { [weak self] notification in
            self?.keyboardWillHide(notification: notification)
        })
    }
    
    deinit {
        if let willShowObserver = willShowObserver {
            NotificationCenter.default.removeObserver(willShowObserver)
        }
        
        if let willHideObserver = willHideObserver {
            NotificationCenter.default.removeObserver(willHideObserver)
        }
    }
    
    private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            onKeyboardWillShow?(keyboardSize.height)
        }
    }
    
    private func keyboardWillHide(notification: Notification) {
        onKeyboardWillHide?()
    }
}
