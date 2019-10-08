//
//  AlertViewHelper.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/8/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class AlertViewHelper {
  
  func showSimpleAlert(title: String,
                       message: String,
                       style: UIAlertController.Style = .alert) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: { _ in
      //Cancel Action
    }))
    return alert
  }
  //    self.present(alert, animated: true, completion: nil)
}
