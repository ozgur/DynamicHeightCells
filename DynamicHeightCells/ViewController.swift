//
//  ViewController.swift
//  DynamicHeightCells
//
//  Created by Ozgur Vatansever on 4/29/16.
//  Copyright © 2016 Ozgur Vatansever. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UserCollectionViewLayoutDelegate {
  
  @IBOutlet weak var layout: UserCollectionViewLayout!
  
  let colors: [UIColor] = [.redColor(), .greenColor(), .yellowColor(), .blueColor(),
                           .orangeColor(), .redColor(), .greenColor(), .yellowColor()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    collectionView!.registerClass(UserCell.self, forCellWithReuseIdentifier: "UserCell")
    layout.delegate = self
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath)
    
    if let cell = cell as? UserCell {
      cell.userView.backgroundColor = colors[indexPath.item % colors.count]
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UserCollectionViewLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    return CGFloat(arc4random_uniform(50) + 100)
  }
}

