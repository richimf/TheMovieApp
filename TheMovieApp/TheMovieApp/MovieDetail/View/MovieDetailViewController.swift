//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UITableViewController {
  
  // MARK: - VIPER
  var presenter: MovieDetailPresenterProtocol?
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    // presenter?.viewWillAppear()
  }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
  
  func loadDetails(_ movie: Movie) {
    // TODO
  }
  
  func showErrorMessage(_ message: String) {
    // TODO
  }
}
