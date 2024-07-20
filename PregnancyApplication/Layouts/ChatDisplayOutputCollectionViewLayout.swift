//
//  ChatDisplayOutputCollectionViewLayout.swift
//  PregnancyApplication
//
//  Created by Space Wizard on 7/11/24.
//

import Foundation
import UIKit

protocol CustomMessageLayoutDelegate: AnyObject {
    // Note: Why do we need to pass in the layout here?
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, isSenderAt indexPath: IndexPath) -> Bool
}

class ChatDisplayOutputCollectionViewLayout: UICollectionViewLayout {
    weak var delegate: CustomMessageLayoutDelegate?
    
    private var isSenderAtPrevious: Bool? = nil
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        contentHeight = 0
        
        let section = 0
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: section)
            
            let itemSize = delegate?.collectionView(collectionView, layout: self, sizeForItemAt: indexPath) ?? CGSize(width: contentWidth, height: 73)
            let isSender = delegate?.collectionView(collectionView, layout: self, isSenderAt: indexPath) ?? false
            let xOffset = isSender ? UIScreen.main.bounds.width - itemSize.width : 16
            
            let spacing: CGFloat
            if let isSenderAtPrevious = isSenderAtPrevious {
                spacing = isSenderAtPrevious == isSender ? 4 : 39
            } else {
                // Meaning that we are at the first item if isSenderAtPrevious hasn't been set yet
                spacing = 0
            }
            
            // Content height will always be set at the bottom of the collection view due to contentHeight = frame.maxY
            let frame = CGRect(x: xOffset, y: contentHeight + spacing, width: itemSize.width, height: itemSize.height + 36)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.frame = frame
            cache.append(attributes)
            contentHeight = frame.maxY
            
            isSenderAtPrevious = isSender
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.indexPath == indexPath }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

}
