//
//  MovieTableViewCell.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UITableViewCellReusableView {

  weak var delegate: MovieTableViewCellDelegate?

  @IBOutlet private weak var imageCover: UIImageView!
  @IBOutlet private weak var labelTitle: UILabel!
  @IBOutlet private weak var labelDescription: UILabel!
  @IBOutlet private weak var buttonWatch: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func setup(with movie: Movie) {
    //self.imageCover.image = movie.cover
    self.labelTitle.text = movie.title
    let rating: Float = movie.rating ?? 0.0
    let votes: Int = movie.voteCount ?? 0
    let date: String = movie.releaseDate ?? ""
    self.labelDescription.text = "\(rating)★  \(votes)✓  \(date)"
  }

  @IBAction func watchTrailer(_ sender: Any) {
    delegate?.showMovieTrailer()
  }
}
