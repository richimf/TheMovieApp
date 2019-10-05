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
  
  private var coverImageView: ImageLoader = {
    let imageView = ImageLoader()
    imageView.image = UIImage()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setup(with movie: Movie) {
    self.imageCover.image = nil
    self.imageCover.setRoundedCorners(radius: 10)
    self.labelTitle.text = movie.title
    self.labelDescription.text = MovieDetails.formatInfo(of: movie)
    self.coverImageView.loadImage(of: movie)
    self.imageCover.isHidden = false
    self.imageCover.image = self.coverImageView.image
  }
  
  //  func loadImage(of movie: Movie, from cache: NSCache<NSString, UIImage>?) {
  //    guard let path = movie.posterPath else { return }
  //    let key = NSString(string: "\(movie.id)")
  //    let fullPath: String = "\(APIUrls.img.rawValue)\(path)"
  //
  //    if let cacheStorage = cache, let cachedImage = cacheStorage.object(forKey: key) {
  //      DispatchQueue.main.async {
  //        self.imageCover.image = cachedImage
  //        self.imageCover.isHidden = false
  //      }
  //    } else {
  //      DispatchQueue.global(qos: .background).async {
  //        guard
  //          let url: URL = URL(string: fullPath),
  //          let data = try? Data(contentsOf: url),
  //          let image: UIImage = UIImage(data: data)
  //          else { return }
  //        DispatchQueue.main.async {
  //          cache?.setObject(image, forKey: key)
  //          if let imgch = cache, let cachedImage = imgch.object(forKey: key) {
  //            self.imageCover.image = cachedImage
  //            self.imageCover.isHidden = false
  //          }
  //        }
  //      }
  //    }
  //  }
  
  @IBAction func watchTrailer(_ sender: Any) {
    delegate?.showMovieTrailer()
  }
}
