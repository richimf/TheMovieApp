//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var searchBar: UISearchBar!
  @IBOutlet private weak var segmentedControl: UISegmentedControl!

  private lazy var identifier: String = MovieTableViewCell.reuseIdentifier()
  private let cellHeight: CGFloat = 175.0
  
  // MARK: - VIPER
  var presenter: CatalogPresenterProtocol?
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
  }

  private func setup() {
    CatalogRouter.createModule(view: self)
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.estimatedRowHeight = cellHeight
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: identifier)
  }
}

extension CatalogViewController: CatalogViewProtocol {
  func loadMovies(_ movies: [Movie]) {
    // TODO
  }
  
  func showErrorMessage(_ message: String) {
    // TODO
  }
}

// MARK: - TABLEVIEW Delegate
extension CatalogViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

}

// MARK: - TABLEVIEW DataSource
extension CatalogViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.getNumberOfItems() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let movie = presenter?.getItem(at: indexPath.row) else { return UITableViewCell() }
    return setupCell(tableView, identifier: identifier, row: indexPath.row, data: movie, delegate: self)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("You tapped cell number \(indexPath.row).")
  }
}

// MARK: - CELL Delegate Protocol
extension CatalogViewController: MovieTableViewCellDelegate {
  func showMovieTrailer() {
    print(#function)
  }
}
