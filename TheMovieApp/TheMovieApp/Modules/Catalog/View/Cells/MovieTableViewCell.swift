//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UITableViewCellReusableView {
  
  weak var delegate: MovieTableViewCellDelegate?
  
  @IBOutlet private weak var imageCover: UIImageView!
  @IBOutlet private weak var labelTitle: UILabel!
  @IBOutlet private weak var labelDescription: UILabel!
  @IBOutlet private weak var buttonWatch: UIButton!
  
  private let genericTitle: String = "Movie"
  private var movie: Movie?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.labelTitle.text = genericTitle
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setup(with movie: Movie, image: UIImage? = nil) {
    self.movie = movie
    self.imageCover.setRoundedCorners(radius: 10)
    if let title = movie.title {
      self.labelTitle.text = title
    }
    if let name = movie.name{
      self.labelTitle.text = name
    }
    self.labelDescription.text = MovieDetails.formatInfo(of: movie)
    self.imageCover.isHidden = false
    if let image = image {
      self.imageCover.image = image
    }
  }
  
  @IBAction func watchTrailer(_ sender: Any) {
    self.buttonWatch.bounce()
    guard let movie = movie else { return }
    delegate?.showMovieTrailer(of: movie)
  }
}
