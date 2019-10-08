//
//  MovieDetailViewController.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {
    
  @IBOutlet private weak var viewPlayerVideo: YTPlayerView!
  @IBOutlet private weak var imageCover: UIImageView!
  @IBOutlet private weak var labelMovieName: UILabel!
  @IBOutlet private weak var labelMovieDetails: UILabel!
  @IBOutlet private weak var buttonWatchTrailer: RoundButton!
  @IBOutlet private weak var textViewMovieDescription: UITextView!
  
  // MARK: - VIPER
   var presenter: MovieDetailPresenterProtocol?
  
  private var movie: Movie?
  
  private let navigationTitle: String = "Descripción"
  private let nowPlayingTitle: String = "Reproduciendo"
  private let notAvailableTitle: String = "No disponible"

  // observe videokey changes then perform loading
  private var videoKey: String = "" {
    didSet {
      if !videoKey.isEmpty {
        self.imageCover.isHidden = true
        self.viewPlayerVideo.load(withVideoId: videoKey, playerVars: YouTubeParams)
      }
    }
  }
  
  // MARK: - OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    self.imageCover.alpha = 0
    presenter?.loadDetails()
    self.navigationItem.title = navigationTitle
    self.viewPlayerVideo.delegate = self
  }

  @IBAction func watchTrailer(_ sender: Any) {
    buttonWatchTrailer.bounce()
    presenter?.loadVideo()
  }
}

// MARK: - DETAIL VIEW PROTOCOL
extension MovieDetailViewController: MovieDetailViewProtocol {
  
  func loadImage(_ image: UIImage) {
    self.imageCover.image = image
    self.imageCover.setRoundedCorners(radius: 10)
    Animator.showFade(view: imageCover)
  }
  
  func loadDetails(_ movie: Movie) {
    self.movie = movie
    if let title = movie.title {
      self.labelMovieName.text = title
    }
    if let name = movie.name {
      self.labelMovieName.text = name
    }
    self.labelMovieDetails.text = MovieDetails.formatInfo(of: movie)
    self.textViewMovieDescription.text = movie.overview
  }
  
  func loadVideo(_ key: String?) {
    if let key = key{
      self.videoKey = key
      self.buttonWatchTrailer.setTitle(self.nowPlayingTitle, for: .normal)
    } else {
      self.buttonWatchTrailer.setTitle(self.notAvailableTitle, for: .normal)
    }
    self.buttonWatchTrailer.isEnabled = false
  }
  
  func showErrorMessage(_ message: String) {
    let alert = AlertViewHelper().showSimpleAlert(title: "Error", message: message)
    self.present(alert, animated: true, completion: nil)
  }
}

// MARK: - YOUTUBE VIDEO PROTOCOLS
extension MovieDetailViewController : YTPlayerViewDelegate {
  func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
    self.viewPlayerVideo.playVideo()
  }
}
