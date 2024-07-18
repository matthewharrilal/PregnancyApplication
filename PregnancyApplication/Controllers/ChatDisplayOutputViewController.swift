//
//  ChatDisplayOutputViewController.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/11/24.
//

import Foundation
import UIKit

class ChatDisplayOutputViewController: UIViewController {
    
    var messages: [(String, Bool)] = [("Hello there my name is Matthew and I am reaching out to you regarding your car's extended warranty. Please reach out to us in a timely fashion to discuss further opportunities.", true), ("One two buckle my shoe one two buckle my shoe", false), ("I have come to discuss this partnership in further detail", true), ("I have come to discuss this partnership in further detail", false), ("I come from a distant planet not too far away from here and would like to abduct you all", true), ("I have come to discuss this partnership in further detail", false), ("I come from a distant planet not too far away from here and would like to abduct you all", true), ("I have come to discuss this partnership in further detail", false), ("I come from a distant planet not too far away from here and would like to abduct you all", true)]
    
    private let keyboardManager = KeyboardManager()

    private lazy var collectionView: UICollectionView = {
        let layout = ChatDisplayOutputCollectionViewLayout()
        layout.delegate = self
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ChatDisplayOutputCollectionViewCell.self, forCellWithReuseIdentifier: ChatDisplayOutputCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension ChatDisplayOutputViewController {
    
    private func setup() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
    }
    
    public func messageHasBeenSent(_ text: String) {
        messages.append((text, false))
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            collectionView.reloadData()
            let indexPath = IndexPath(item: messages.count - 1, section: collectionView.numberOfSections - 1)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
}


extension ChatDisplayOutputViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatDisplayOutputCollectionViewCell.identifier, for: indexPath) as? ChatDisplayOutputCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(message: messages[indexPath.row].0, style: messages[indexPath.row].1 ? .sender : .receiver)
        return cell
    }
}

extension ChatDisplayOutputViewController: CustomMessageLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, isSenderAt indexPath: IndexPath) -> Bool {
        messages[indexPath.row].1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.row]
        let width = collectionView.bounds.width * 0.60
        
        // Create a temporary UILabel to calculate the height
        let tempLabel = UILabel()
        tempLabel.text = message.0
        tempLabel.numberOfLines = 0
        tempLabel.font = UIFont.systemFont(ofSize: 17)
        tempLabel.lineBreakMode = .byWordWrapping
        
        // Set the width constraint
        let targetSize = CGSize(width: width - 36, height: .greatestFiniteMagnitude)
        let size = tempLabel.systemLayoutSizeFitting(targetSize,
                                                     withHorizontalFittingPriority: .fittingSizeLevel,
                                                     verticalFittingPriority: .fittingSizeLevel)
        
        // Add padding
        let totalHeight = size.height
        return CGSize(width: size.width + 54, height: totalHeight)
    }
}
