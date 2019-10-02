//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  // MARK: - VIPER
  var presenter: MovieDetailPresenterProtocol?
  
  @IBOutlet private weak var imageCover: UIImageView!
  @IBOutlet private weak var labelMovieName: UILabel!
  @IBOutlet private weak var labelMovieDetails: UILabel!
  @IBOutlet private weak var labelMovieDescription: UILabel!
  @IBOutlet private weak var buttonWatchTrailer: RoundButton!
  @IBOutlet private weak var buttonShare: UIButton!

  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
     presenter?.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
  
  func loadDetails(_ movie: Movie) {
    //self.imageCover.image = movie.cover
    self.labelMovieName.text = movie.title
    self.labelMovieDetails.text = movie.description
    self.labelMovieDescription.text = movie.description
  }
  
  func showErrorMessage(_ message: String) {
    // TODO
  }
}
