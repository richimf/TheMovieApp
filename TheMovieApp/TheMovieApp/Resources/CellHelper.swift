//
//  CellHelper.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/6/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

// MARK: - CELL SETUP HELPER
public class CellHelper {
  
  init() {}
  
  func setupCell(for tableView: UITableView,
                 with identifier: String,
                 row: Int, data: Movie,
                 image: UIImage? = nil,
                 delegate: MovieTableViewCellDelegate) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieTableViewCell else {
      return UITableViewCell()
    }
    cell.setup(with: data, image: image)
    cell.delegate = delegate
    return cell
  }
}
