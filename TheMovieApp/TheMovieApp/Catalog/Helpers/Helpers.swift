//
//  CellHelpers.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - MOVIE DETAIL INFO HELPER
public class MovieDetails {
  static func formatInfo(of movie: Movie) -> String {
    let rating: Float = movie.rating ?? 0.0
    let votes: Int = movie.voteCount ?? 0
    let date: String = movie.releaseDate ?? ""
    return "\(rating)★  \(votes)✓  \(date)"
  }
}

func getCategoryKeyFrom(name: String) -> APIMovieParams {
  switch name {
  case "popular":
    return APIMovieParams.popular
  case "top_rated":
    return APIMovieParams.topRated
  case "upcoming":
    return APIMovieParams.upcoming
  default:
    return APIMovieParams.none
  }
}

// MARK: - LOADER VIEW HELPER for LOTTIE
public class Loader {
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
      UIView.animate(withDuration: 0.4, animations: {
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
}

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

// MARK: - CELL SETUP HELPER
class CellHelper {
  
  init() {}
  
  func setupCell(for tableView: UITableView,
                 with identifier: String,
                 row: Int, data: Movie,
                 delegate: MovieTableViewCellDelegate) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieTableViewCell else {
      return UITableViewCell()
    }
    cell.setup(with: data)
    cell.delegate = delegate
    return cell
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

