//
//  UserCollectionViewLayout.swift
//  AutoLayoutAnimation
//
//  Created by Ozgur Vatansever on 10/26/15.
//  Copyright © 2015 Techshed. All rights reserved.
//

import UIKit

class UserCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
  var height: CGFloat = 0.0
  
  override func copy(with zone: NSZone?) -> Any {
    let copy = super.copy(with: zone) as! UserCollectionViewLayoutAttributes
    copy.height = height
    return copy
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    if let object = object as? UserCollectionViewLayoutAttributes {
      if height != object.height {
        return false
      }
      return super.isEqual(object)
    }
    return false
  }
}

protocol UserCollectionViewLayoutDelegate: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UserCollectionViewLayout, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

class UserCollectionViewLayout: UICollectionViewLayout {
  
  fileprivate var contentHeight: CGFloat = 0.0
  fileprivate var allAttributes = [UserCollectionViewLayoutAttributes]()
  
  weak var delegate: UserCollectionViewLayoutDelegate!
  
  var numberOfColumns: Int = 2
  
  fileprivate var numberOfItems: Int {
    return collectionView?.numberOfItems(inSection: 0) ?? 0
  }
  
  fileprivate var contentWidth: CGFloat {
    return (collectionView?.bounds ?? CGRect.zero).width
  }
  
  fileprivate var itemWidth: CGFloat {
    return round(contentWidth / CGFloat(numberOfColumns))
  }
  
  override var collectionViewContentSize : CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override class var layoutAttributesClass : AnyClass {
    return UserCollectionViewLayoutAttributes.self
  }

  override func prepare() {
    if allAttributes.isEmpty {
      
      let xOffsets = (0..<numberOfColumns).map { index -> CGFloat in
        return CGFloat(index) * itemWidth
      }
      
      var yOffsets = Array(repeating: CGFloat(0), count: numberOfColumns)
      var column = 0
      
      for item in 0..<numberOfItems {
        let indexPath = IndexPath(item: item, section: 0)
        let attributes = UserCollectionViewLayoutAttributes(forCellWith: indexPath)

        let cellHeight = delegate.collectionView(collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
        
        let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: itemWidth, height: cellHeight)
        
        attributes.frame = frame
        attributes.height = cellHeight
        
        allAttributes.append(attributes)
        
        yOffsets[column] = yOffsets[column] + cellHeight
        
        column = (column >= numberOfColumns - 1) ? 0 : column + 1
        contentHeight = max(contentHeight, frame.maxY)
      }
    }
  }

  override func invalidateLayout() {
    allAttributes.removeAll()
    contentHeight = 0
    super.invalidateLayout()
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return allAttributes.filter { attribute -> Bool in
      return rect.intersects(attribute.frame)
    }
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return allAttributes.filter { attribute -> Bool in
      return attribute.indexPath == indexPath
    }.first
  }
}
