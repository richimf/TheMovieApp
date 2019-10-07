//
//  Extensions.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/6/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - UIVIEW ANIMATION EXTENSIONS
extension UIView {
  func pinEdgesToSuperView() {
    guard let superView = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
    leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
    bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
  }
}

// MARK: - UIIMAGEVIEW EXTENSION
extension UIImageView {
  func setRoundedCorners(radius: Int) {
    self.layer.cornerRadius = CGFloat(radius)
    self.layer.masksToBounds = true
    self.clipsToBounds = true
  }
}

// MARK: - UIBUTTON ANIMATION EXTENSIONS
extension UIButton {
  func bounce() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.95
    pulse.toValue = 1.0
    pulse.autoreverses = false
    pulse.repeatCount = 1
    pulse.initialVelocity = 0.4
    pulse.damping = 1.0
    layer.add(pulse, forKey: "bounce")
  }
}

// MARK: - COLORS EXTENSION
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
