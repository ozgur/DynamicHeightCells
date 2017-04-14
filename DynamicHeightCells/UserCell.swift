//
//  UserCell.swift
//  DynamicHeightCells
//
//  Created by Ozgur Vatansever on 4/29/16.
//  Copyright © 2016 Ozgur Vatansever. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
  
  let userView = UIView(frame: CGRect.zero)
  fileprivate var heightLayoutConstraint: NSLayoutConstraint!
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    let attributes = layoutAttributes as! UserCollectionViewLayoutAttributes
    heightLayoutConstraint.constant = attributes.height
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    userView.translatesAutoresizingMaskIntoConstraints = false

    contentView.addSubview(userView)
    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "H:|[userView]|",
      options: NSLayoutFormatOptions.alignAllCenterY,
      metrics: nil,
      views: ["userView": userView])
    )
    
    contentView.addConstraints(NSLayoutConstraint.constraints(
      withVisualFormat: "V:|[userView]|",
      options: NSLayoutFormatOptions.alignAllCenterX,
      metrics: nil,
      views: ["userView": userView])
    )
    
    heightLayoutConstraint = NSLayoutConstraint(
      item: userView,
      attribute: NSLayoutAttribute.height,
      relatedBy: NSLayoutRelation.equal,
      toItem: nil,
      attribute: NSLayoutAttribute.notAnAttribute,
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
