//
//  LoaderViewController.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/4/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit
import Lottie

public class LoaderView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    self.backgroundColor = Colors().Main
    let animationView = AnimationView(name: "loader")
    animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
    animationView.center = self.center
    animationView.animationSpeed = 0.5
    animationView.contentMode = .scaleAspectFill
    animationView.loopMode = .loop
    self.addSubview(animationView)
    animationView.play()
    animationView.translatesAutoresizingMaskIntoConstraints = false
    animationView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    animationView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    animationView.widthAnchor.constraint(equalToConstant: 280).isActive = true
    animationView.heightAnchor.constraint(equalToConstant: 108).isActive = true
  }
}
