//
//  BlurEffectHelper.swift
//  TheMovieApp
//
//  Created by Richie on 10/7/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class BlurEffectHelper {
  static func getBlurEffect(frame: CGRect, style: UIBlurEffect.Style) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: style)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = frame
    return blurEffectView
  }
}
