//
//  UserCell.swift
//  DynamicHeightCells
//
//  Created by Ozgur Vatansever on 4/29/16.
//  Copyright © 2016 Ozgur Vatansever. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  
  let userView = UIView(frame: CGRectZero)
  private var heightLayoutConstraint: NSLayoutConstraint!
  
  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
    let attributes = layoutAttributes as! UserCollectionViewLayoutAttributes
    heightLayoutConstraint.constant = attributes.height
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    userView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(userView)
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      "H:|[userView]|",
      options: NSLayoutFormatOptions.AlignAllCenterY,
      metrics: nil,
      views: ["userView": userView])
    )
    
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
      "V:|[userView]|",
      options: NSLayoutFormatOptions.AlignAllCenterX,
      metrics: nil,
      views: ["userView": userView])
    )
    
    heightLayoutConstraint = NSLayoutConstraint(
      item: userView,
      attribute: NSLayoutAttribute.Height,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 0.0,
      constant: 0.0
    )
    heightLayoutConstraint.priority = 500
    contentView.addConstraint(heightLayoutConstraint)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
