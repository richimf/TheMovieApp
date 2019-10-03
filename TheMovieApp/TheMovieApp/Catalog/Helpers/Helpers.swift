//
//  CellHelpers.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

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

func movieDetailConstructor(of movie: Movie) -> String {
  let rating: Float = movie.rating ?? 0.0
  let votes: Int = movie.voteCount ?? 0
  let date: String = movie.releaseDate ?? ""
  return "\(rating)★  \(votes)✓  \(date)"
}

extension UIImageView {
  func setRoundedCorners(radius: Int) {
    self.layer.cornerRadius = CGFloat(radius)
    self.clipsToBounds = true
  }
}
