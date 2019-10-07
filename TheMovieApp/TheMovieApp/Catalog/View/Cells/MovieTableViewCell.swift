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
  
  private var coverImageView: ImageLoader = {
    let imageView = ImageLoader()
    imageView.image = UIImage()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.labelTitle.text = genericTitle
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setup(with movie: Movie, image: UIImage? = nil) {
    self.imageCover.image = nil
    self.imageCover.setRoundedCorners(radius: 10)
    if let title = movie.title {
      self.labelTitle.text = title
    }
    if let name = movie.name{
      self.labelTitle.text = name
    }
    self.labelDescription.text = MovieDetails.formatInfo(of: movie)
    // If image is given just set it otherwise download it
    if let image = image {
      self.coverImageView.image = image
    } else {
      self.coverImageView.loadCompressedImage(of: movie, size: self.imageCover.frame.size)
    }
    self.imageCover.isHidden = false
    self.imageCover.image = self.coverImageView.image
  }
  
  @IBAction func watchTrailer(_ sender: Any) {
    self.buttonWatch.bounce()
    delegate?.showMovieTrailer()
  }
}
