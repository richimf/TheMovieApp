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
    
//  private var cover: UIImage?
//  private let coverImageView: UIImageView = {
//    let imageView = UIImageView()
//    guard let image = self.cover else { return imageView }
//    imageView.image = image
//    imageView.layer.cornerRadius = 5
//    imageView.clipsToBounds = true
//    return imageView
//  }()

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
    //self.cover = Downloadimage(from: movie.posterPath)
    self.labelTitle.text = movie.title
    self.labelDescription.text = movieDetailConstructor(of: movie)
  }
  
  func loadImage(key: NSString, imageCache: NSCache<NSString, UIImage>) {
    if let cachedImage = imageCache.object(forKey: key) {
        self.imageCover.image = cachedImage
    }
  }

  @IBAction func watchTrailer(_ sender: Any) {
    delegate?.showMovieTrailer()
  }
}
