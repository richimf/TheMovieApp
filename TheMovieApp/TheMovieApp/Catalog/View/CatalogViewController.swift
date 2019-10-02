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

  private func setup() {
    // Setup Viper Router
    CatalogRouter.createModule(view: self)
    // Setup TableView
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.estimatedRowHeight = cellHeight
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: identifier)
    // Setup Segmented Control
    setupSegmentedControl()
    // Load Movies Info
    self.presenter?.loadMoviesData()
  }
  
  @IBAction func segmentedActions(_ sender: Any) {
    let section: Int = segmentedControl.selectedSegmentIndex
    scrollTo(section: section)
  }

  private func setupSegmentedControl() {
    presenter?.setupSegmentedControl(control: &segmentedControl)
  }

  private func scrollTo(section: Int) {
    let indexPath = IndexPath(row: 0, section: section)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
}

extension CatalogViewController: CatalogViewProtocol {

  func loadMovies() {
    self.tableView.reloadData()
  }
  
  func showErrorMessage(_ message: String) {
  }
}

// MARK: - TABLEVIEW Delegate & DataSource
extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return presenter?.getNumberOfSections() ?? 0
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return presenter?.nameForSection(section)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.getNumberOfItems() ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let movie = getItemAt(indexPath) else { return UITableViewCell() }
    return setupCell(for: tableView, with: identifier, row: indexPath.row, data: movie, delegate: self)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let movie = getItemAt(indexPath) else { return }
    presenter?.showDetailView(for: movie, from: self)
  }

  private func getItemAt(_ indexPath: IndexPath) -> Movie? {
    presenter?.getItem(at: indexPath.row)
  }
}

// MARK: - CELL Delegate Protocol
extension CatalogViewController: MovieTableViewCellDelegate {
  func showMovieTrailer() {
    print(#function)
  }
}
