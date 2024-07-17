//
//  ViewController.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 6/9/24.
//

import UIKit

class ChatViewController: UIViewController {
    
    enum Constants {
        static var keyboardPadding: CGFloat = 5
    }
    
    private let keyboardManager = KeyboardManager()
    private var messageInputViewBottomConstraint: NSLayoutConstraint!
    
    private let messageInputView: MessageInputView = {
        let view = MessageInputView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
}

// MARK: UI Related Methods
private extension ChatViewController {
    
    func setup() {
        view.backgroundColor = .white
        view.addSubview(messageInputView)
        setupKeyboardManager()
        
        messageInputViewBottomConstraint = messageInputView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor
        )
        
        NSLayoutConstraint.activate([
            messageInputViewBottomConstraint,
            messageInputView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            messageInputView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            messageInputView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            )
        ])
        
        addDisplayOutputViewController()
    }
    
    func addDisplayOutputViewController() {
        let displayOutputViewController = ChatDisplayOutputViewController()
        addChild(displayOutputViewController)
        view.addSubview(displayOutputViewController.view)
        
        displayOutputViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            displayOutputViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            displayOutputViewController.view.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            displayOutputViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            displayOutputViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        displayOutputViewController.didMove(toParent: self)
    }
    
    func setupKeyboardManager() {
        keyboardManager.onKeyboardWillShow = { [weak self] keyboardHeight in
            UIView.animate(withDuration: 0.25, animations: {
                guard let self = self else { return }
                self.messageInputViewBottomConstraint.constant = -(keyboardHeight - self.view.safeAreaInsets.bottom + Constants.keyboardPadding)
                self.view.layoutIfNeeded()
            })
        }
        
        keyboardManager.onKeyboardWillHide = { [weak self] in
            guard let self = self else { return }
            self.messageInputViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

