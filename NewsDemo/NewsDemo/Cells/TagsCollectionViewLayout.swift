//
//  TagsCollectionViewLayout.swift
//  NewsDemo
//
//  Created by SOWJI on 23/11/20.
//

import Foundation
import UIKit

// Custom CollectionViewLayout to show the labels based on width
public class TagsCollectionViewLayout: UICollectionViewFlowLayout {
    var delegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    
    // UICollectionView calls these four methods to determine the layout information.
    // Implement -layoutAttributesForElementsInRect: to return layout attributes for for supplementary or decoration views, or to perform layout in an as-needed-on-screen fashion.
    // Additionally, all layout subclasses should implement -layoutAttributesForItemAtIndexPath: to return layout attributes instances on demand for specific index paths.
    // If the layout supports any supplementary or decoration view types, it should also implement the respective atIndexPath: methods for those types.
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesCollection = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var updatedAttributes = [UICollectionViewLayoutAttributes]()
        attributesCollection.forEach({ (originalAttributes) in
            guard originalAttributes.representedElementKind == nil else {
                updatedAttributes.append(originalAttributes)
                return
            }
            
            if let updatedAttribute = self.layoutAttributesForItem(at: originalAttributes.indexPath) {
                updatedAttributes.append(updatedAttribute)
            }
        })
        
        return updatedAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }
        
        guard let collectionView = self.collectionView else {
            return attributes
        }
        
        let firstInSection: Bool = indexPath.item == 0
        guard !firstInSection else {
            let section = attributes.indexPath.section
            let x = self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section).left ?? self.sectionInset.left
            attributes.frame.origin.x = x
            return attributes
        }
        
        let previousAttributes = self.layoutAttributesForItem(at: IndexPath(item: indexPath.item - 1, section: indexPath.section))
        let previousFrame: CGRect = previousAttributes?.frame ?? CGRect()
        let firstInRow = previousAttributes?.center.y != attributes.center.y
        
        guard !firstInRow else {
            let section = attributes.indexPath.section
            let x = self.delegate?.collectionView?(collectionView, layout: self, insetForSectionAt: section).left ?? self.sectionInset.left
            attributes.frame.origin.x = x
            return attributes
        }
        
        let interItemSpacing: CGFloat = (collectionView.delegate as? UICollectionViewDelegateFlowLayout)?
            .collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: indexPath.section) ?? self.minimumInteritemSpacing
        // Setting up the X cordinate of item based on previous elemt size
        let x = previousFrame.origin.x + previousFrame.width + interItemSpacing
        attributes.frame = CGRect(x: x,
                                  y: attributes.frame.origin.y,
                                  width: attributes.frame.width,
                                  height: attributes.frame.height)
        
        return attributes
    }
}
