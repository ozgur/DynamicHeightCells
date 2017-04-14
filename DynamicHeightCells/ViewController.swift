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
  
  let colors: [UIColor] = [.red, .green, .yellow, .blue,
                           .orange, .red, .green, .yellow]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    collectionView!.register(UserCell.self, forCellWithReuseIdentifier: "UserCell")
    layout.delegate = self
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 50
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath)
    
    if let cell = cell as? UserCell {
      cell.userView.backgroundColor = colors[indexPath.item % colors.count]
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UserCollectionViewLayout, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
    
    return CGFloat(arc4random_uniform(50) + 100)
  }
}

