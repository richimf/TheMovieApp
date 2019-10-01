//
//  CellHelpers.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

func setupCell(_ tableView: UITableView, identifier: String, row: Int, data: Movie, delegate: MovieTableViewCellDelegate) -> UITableViewCell {
  guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieTableViewCell else {
      return UITableViewCell()
  }
  cell.setup(with: data)
  cell.delegate = delegate
  return cell
}
