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
  
  let imageCache = NSCache<NSString, UIImage>()
  
  private lazy var identifier: String = MovieTableViewCell.reuseIdentifier()
  private let cellHeight: CGFloat = 175.0
  
  // MARK: - VIPER
  var presenter: CatalogPresenterProtocol?
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  // MARK: - IBACTIONS
  @IBAction func segmentedActions(_ sender: Any) {
    let section: Int = segmentedControl.selectedSegmentIndex
    scrollTo(section: section)
  }
  
  // MARK: - SETUP AND PRIVATE METHODS
  private func setup() {
    // Remove NavigationBar separator line
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.tintColor = Colors().Main
    self.navigationController?.navigationBar.topItem?.title = "Movies"
    // Segmented control basic setup
    segmentedControl.isEnabled = false
    segmentedControl.isHidden = true
    // Setup Viper Router
    CatalogRouter.createModule(view: self)
    // Setup TableView
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.estimatedRowHeight = cellHeight
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: identifier)
    // Load Movies Info
    self.presenter?.loadMoviesData()
  }

  private func setupSegmentedControl() {
    presenter?.setupSegmentedControl(control: &segmentedControl)
  }

  private func scrollTo(section: Int) {
    let indexPath = IndexPath(row: 0, section: section)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
  
  private func getItemAt(_ indexPath: IndexPath) -> Movie? {
     return presenter?.getItemAt(indexPath: indexPath)
   }
}

extension CatalogViewController: CatalogViewProtocol {

  func loadMovies() {
    self.tableView.reloadData()
    setupSegmentedControl()
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
    return presenter?.getNumberOfItemsAt(section) ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let movie = getItemAt(indexPath) else { return UITableViewCell() }
    return setupCell(for: tableView, with: identifier, row: indexPath.row, data: movie, delegate: self)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let movie = getItemAt(indexPath) else { return }
    presenter?.showDetailView(for: movie, from: self)
    self.tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.font = UIFont(name: "Futura", size: 20)
    header.textLabel?.textColor = Colors().Main
    header.contentView.backgroundColor = UIColor.white
  }

}

// MARK: - CELL Delegate Protocol
extension CatalogViewController: MovieTableViewCellDelegate {
  func showMovieTrailer() {
    print(#function)
  }
}
