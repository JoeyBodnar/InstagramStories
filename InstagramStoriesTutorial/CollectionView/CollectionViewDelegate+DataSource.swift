//
//  CollectionViewDelegate+DataSource.swift
//  InstagramStoriesTutorial
//
//  Created by Stephen Bodnar on 8/13/18.
//  Copyright © 2018 Stephen Bodnar. All rights reserved.
//

import UIKit

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == (stories.count - 1)  { return } // because this is the last item
        let nextItem = indexPath.item + 1
        let nextCell = IndexPath(item: nextItem, section: 0)
        lastScrollDirection = .left
        collectionView.scrollToItem(at: nextCell, at: UICollectionViewScrollPosition.left, animated: true)
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCell {
            cell.setup(with: stories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}

