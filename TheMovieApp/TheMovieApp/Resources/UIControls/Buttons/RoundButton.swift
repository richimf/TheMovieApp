//
//  CustomUIElements.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

  private let customBGColor: UIColor = UIColor(red:0.98, green:0.06, blue:0.32, alpha:1.00)
  @IBInspectable var cornerRadius: CGFloat = 15 {
    didSet {
      refreshCorners(value: cornerRadius)
    }
  }

  @IBInspectable var backgroundImageColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1) {
    didSet {
      refreshColor(color: customBGColor)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    sharedInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    sharedInit()
  }
  
  override func prepareForInterfaceBuilder() {
    sharedInit()
  }
  
  private func sharedInit() {
    refreshCorners(value: cornerRadius)
    refreshColor(color: backgroundImageColor)
  }
  
  func refreshCorners(value: CGFloat) {
    layer.cornerRadius = value
  }
  
  func refreshColor(color: UIColor) {
    let image = createImage(color: color)
    setBackgroundImage(image, for: UIControl.State.normal)
    clipsToBounds = true
  }

  private func createImage(color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
    color.setFill()
    UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
    return image
  }
}
