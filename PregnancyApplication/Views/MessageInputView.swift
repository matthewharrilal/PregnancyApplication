//
//  MessageInputView.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/10/24.
//

import Foundation
import UIKit

class MessageInputView: UIView {
    
    enum Constants {
        static var cornerRadius: CGFloat = 18
        static var textViewBorderWidth: CGFloat = 1
        static var textViewLeadingConstant: CGFloat = 18
        static var placeholderLabelLeadingConstant: CGFloat = 12
        static var textViewHeight: CGFloat = 38
    }
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.layer.borderWidth = Constants.textViewBorderWidth
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 17)
        textView.contentInset = .init(top: 0, left: 14, bottom: 0, right: 0)
        textView.clipsToBounds = true
        return textView
    }()
    
    private let textViewPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Message"
        label.textColor = .lightGray
        label.sizeToFit()
        return label
    }()
    
    private var textViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UI Related Methods
extension MessageInputView {
    
    private func setup() {
        addSubview(textView)
        textView.addSubview(textViewPlaceholderLabel)
        textViewHeightConstraint = textView.heightAnchor.constraint(
            equalToConstant: Constants.textViewHeight
        )
        
        NSLayoutConstraint.activate([
            // Text View
            textView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.textViewLeadingConstant
            ),
            textView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            textView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            textView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.textViewLeadingConstant
            ),
            textViewHeightConstraint,
            
            // Text View Placeholder Label
            textViewPlaceholderLabel.leadingAnchor.constraint(
                equalTo: textView.leadingAnchor,
                constant: Constants.placeholderLabelLeadingConstant
            ),
            textViewPlaceholderLabel.centerYAnchor.constraint(
                equalTo: textView.centerYAnchor
            )
        ])
    }
    
    func updateLayoutForKeyboard(height: CGFloat) {
//        textViewHeightConstraint.constant = Constants.textViewHeight
    }
}

// MARK: UITextView Delegate Related Methods
extension MessageInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholderLabel.text = ""
    }
}
