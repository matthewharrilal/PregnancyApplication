//
//  ChatDisplayOutputCollectionViewCell.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/11/24.
//

import Foundation
import UIKit

class ChatDisplayOutputCollectionViewCell: UICollectionViewCell {
    
    enum Style {
        case sender
        case receiver
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private var containerViewLeadingConstraint: NSLayoutConstraint!
    private var containerViewTrailingConstraint: NSLayoutConstraint!
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(message: String, style: Style) {
        
        messageTextLabel.text = message
        switch style {
        case .receiver:
            containerView.backgroundColor = .green
        case .sender:
            containerView.backgroundColor = .red
        }
        
        contentView.layoutIfNeeded()
        containerView.layoutIfNeeded()
    }
}

private extension ChatDisplayOutputCollectionViewCell {
    
    func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(messageTextLabel)
 
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.75),
            
            messageTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
            messageTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            messageTextLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 18),
            messageTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -18),
        ])
    }
}
