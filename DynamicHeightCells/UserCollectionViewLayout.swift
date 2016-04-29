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
  
  override func copyWithZone(zone: NSZone) -> AnyObject {
    let copy = super.copyWithZone(zone) as! UserCollectionViewLayoutAttributes
    copy.height = height
    return copy
  }
  
  override func isEqual(object: AnyObject?) -> Bool {
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
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UserCollectionViewLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class UserCollectionViewLayout: UICollectionViewLayout {
  
  private var contentHeight: CGFloat = 0.0
  private var allAttributes = [UserCollectionViewLayoutAttributes]()
  
  weak var delegate: UserCollectionViewLayoutDelegate!
  
  var numberOfColumns: Int = 2
  
  private var numberOfItems: Int {
    return collectionView?.numberOfItemsInSection(0) ?? 0
  }
  
  private var contentWidth: CGFloat {
    return CGRectGetWidth(collectionView?.bounds ?? CGRectZero)
  }
  
  private var itemWidth: CGFloat {
    return round(contentWidth / CGFloat(numberOfColumns))
  }
  
  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override class func layoutAttributesClass() -> AnyClass {
    return UserCollectionViewLayoutAttributes.self
  }

  override func prepareLayout() {
    if allAttributes.isEmpty {
      
      let xOffsets = (0..<numberOfColumns).map { index -> CGFloat in
        return CGFloat(index) * itemWidth
      }
      
      var yOffsets = Array(count: numberOfColumns, repeatedValue: CGFloat(0))
      var column = 0
      
      for item in 0..<numberOfItems {
        let indexPath = NSIndexPath(forItem: item, inSection: 0)
        let attributes = UserCollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)

        let cellHeight = delegate.collectionView(collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
        
        let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: itemWidth, height: cellHeight)
        
        attributes.frame = frame
        attributes.height = cellHeight
        
        allAttributes.append(attributes)
        
        yOffsets[column] = yOffsets[column] + cellHeight
        
        column = (column >= numberOfColumns - 1) ? 0 : column + 1
        contentHeight = max(contentHeight, CGRectGetMaxY(frame))
      }
    }
  }

  override func invalidateLayout() {
    allAttributes.removeAll()
    contentHeight = 0
    super.invalidateLayout()
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return allAttributes.filter { attribute -> Bool in
      return CGRectIntersectsRect(rect, attribute.frame)
    }
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    return allAttributes.filter { attribute -> Bool in
      return attribute.indexPath == indexPath
    }.first
  }
}
