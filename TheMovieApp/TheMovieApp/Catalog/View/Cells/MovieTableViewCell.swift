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

  func setup(with movie: Movie){
    //self.imageCover.image = movie.cover
    self.labelTitle.text = movie.title
    self.labelDescription.text = movie.description
  }

  @IBAction func watchTrailer(_ sender: Any) {
    delegate?.showMovieTrailer()
  }
}
