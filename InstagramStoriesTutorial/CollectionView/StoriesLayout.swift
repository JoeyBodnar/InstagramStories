//
//  StoriesLayout.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/12/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

class StoriesLayout: UICollectionViewLayout {
    var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * 320, height: collectionView!.frame.height)
    }
    
    override func prepare() {
        for item in 0..<collectionView!.numberOfItems(inSection: 0) {
            let itemAsFloat = CGFloat(item)
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let xOrigin = itemAsFloat * collectionView!.frame.width
            let frame = CGRect(x: xOrigin, y: 0, width: collectionView!.frame.width, height: collectionView!.frame.height)
            attributes.frame = frame
            attributesCache.append(attributes)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in attributesCache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
    
}
