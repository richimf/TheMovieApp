//
//  LoaderHelper.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/6/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - LOADER VIEW HELPER for LOTTIE
public class Animator {
  static func show(view: UIView) {
    let window = UIApplication.shared.connectedScenes
      .filter({$0.activationState == .foregroundActive})
      .map({$0 as? UIWindowScene})
      .compactMap({$0})
      .first?.windows
      .filter({$0.isKeyWindow}).first
    window?.addSubview(view)
    view.pinEdgesToSuperView()
  }
  
  static func showFade(view: UIView) {
    view.alpha = 0.0
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      UIView.animate(withDuration: 1.0, animations: {
        view.alpha = 1.0
      })
    }
  }
  
  static func dismiss(view: UIView) {
    let duration = 2.0
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      UIView.animate(withDuration: 1.5, animations: {
        view.alpha = 0.0
      })
    }
  }
  
  static func scaleWhenScrolling(view: UIView, isScrolling: Bool) {
    UIView.animate(withDuration: 0.25, animations: { () -> Void in
      let scale: CGFloat = 0.85
      if isScrolling {
        view.transform = CGAffineTransform(scaleX: scale, y: scale)
      } else {
        view.transform = CGAffineTransform.identity
      }
    })
  }
}
