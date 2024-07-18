//
//  CustomTapView.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/17/24.
//

import Foundation
import UIKit

class CustomTapView: UIView {
    
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CustomTapView {
    
    func setupView() {
        backgroundColor = .systemBlue
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        onTap?()
    }
}
