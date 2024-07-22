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
    private let displayOutputViewControllerProtocol: DisplayOutputViewControllerProtocol
    
    private lazy var messageInputView: MessageInputView = {
        let view = MessageInputView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    init(displayOutputViewControllerProtocol: DisplayOutputViewControllerProtocol) {
        self.displayOutputViewControllerProtocol = displayOutputViewControllerProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        displayOutputViewControllerProtocol.addToParent(self, belowView: messageInputView)
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

extension ChatViewController: MessageSentDelegate {
    
    func messageSent(text: String) {
        displayOutputViewControllerProtocol.messageHasBeenSent(text)
    }
}
