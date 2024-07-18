//
//  MessageInputView.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/10/24.
//

import Foundation
import UIKit

protocol MessageSentDelegate: AnyObject {
    func messageSent(text: String)
}

class MessageInputView: UIView {
    
    enum Constants {
        static var cornerRadius: CGFloat = 18
        static var textViewBorderWidth: CGFloat = 1
        static var textViewLeadingConstant: CGFloat = 36
        static var placeholderLabelLeadingConstant: CGFloat = 12
        static var textViewHeight: CGFloat = 38
    }
    
    weak var delegate: MessageSentDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.cornerRadius
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var sendButtonCTA: CustomTapView = {
        let tapView = CustomTapView(frame: .zero)
        tapView.translatesAutoresizingMaskIntoConstraints = false
        tapView.onTap = { [weak self] in
            guard
                let self = self,
                let text = self.textView.text
            else { return }
            
            delegate?.messageSent(text: text)
        }
        return tapView
    }()
    
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
        addSubview(containerView)
        containerView.addSubview(textView)
        containerView.addSubview(sendButtonCTA)
        textView.addSubview(textViewPlaceholderLabel)
        textViewHeightConstraint = textView.heightAnchor.constraint(
            equalToConstant: Constants.textViewHeight
        )
        
        NSLayoutConstraint.activate([
            // Container View
            containerView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: Constants.textViewLeadingConstant
            ),
            containerView.topAnchor.constraint(
                equalTo: topAnchor
            ),
            containerView.bottomAnchor.constraint(
                equalTo: bottomAnchor
            ),
            containerView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -Constants.textViewLeadingConstant
            ),
            containerView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            
            // Text View
            textView.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            textView.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            textView.bottomAnchor.constraint(
                equalTo: containerView.bottomAnchor
            ),
            textView.trailingAnchor.constraint(
                equalTo: sendButtonCTA.leadingAnchor,
                constant: -5
            ),
            textViewHeightConstraint,
            
            sendButtonCTA.heightAnchor.constraint(equalToConstant: 24),
            sendButtonCTA.widthAnchor.constraint(equalToConstant: 24),
            sendButtonCTA.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            sendButtonCTA.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
            sendButtonCTA.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),

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
}

// MARK: UITextView Delegate Related Methods
extension MessageInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholderLabel.text = ""
    }
}
