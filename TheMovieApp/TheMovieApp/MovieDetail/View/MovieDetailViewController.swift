//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  // MARK: - VIPER
  var presenter: MovieDetailPresenterProtocol?
  
  @IBOutlet private weak var imageCover: UIImageView!
  @IBOutlet private weak var labelMovieName: UILabel!
  @IBOutlet private weak var labelMovieDetails: UILabel!
  @IBOutlet private weak var buttonWatchTrailer: RoundButton!
  @IBOutlet private weak var textViewMovieDescription: UITextView!
  
  private let navigationTitle: String = "Descripción"
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageCover.alpha = 0
    presenter?.loadDetails()
    self.navigationItem.title = navigationTitle
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }
  
  @IBAction func watchTrailer(_ sender: Any) {
    buttonWatchTrailer.bounce()
  }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
  
  func loadImage(_ image: UIImage) {
    self.imageCover.image = image
    self.imageCover.setRoundedCorners(radius: 10)
    Loader.showFade(view: imageCover)
  }
  
  func loadDetails(_ movie: Movie) {
    if let title = movie.title {
      self.labelMovieName.text = title
    }
    if let name = movie.name {
      self.labelMovieName.text = name
    }
    self.labelMovieDetails.text = MovieDetails.formatInfo(of: movie)
    self.textViewMovieDescription.text = movie.overview
  }
  
  func showErrorMessage(_ message: String) {
    // TODO
  }
}
