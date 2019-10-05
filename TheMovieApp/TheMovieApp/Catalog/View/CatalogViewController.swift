//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  // IBOUTLETS
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  @IBOutlet private weak var buttonSearch: UIBarButtonItem!
  
  // IDENTIFIERS
  private lazy var identifier: String = MovieTableViewCell.reuseIdentifier()
  
  // CONSTANTS
  private let cellHeight: CGFloat = 175.0
  private let titleNavigation: String = "Movies"
  private let fontSection: UIFont? = UIFont(name: "Futura", size: 20)
  private lazy var loaderView: LoaderView = LoaderView()

  // SEARCH
  private let searchPlaceholder: String = "Busca tu película favorita..."
  private var searchController = UISearchController(searchResultsController: nil)
  
  // MARK: - VIPER
  var presenter: CatalogPresenterProtocol?
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    Loader.show(view: loaderView)
    setup()
    self.presenter?.loadMoviesData()
  }
  
  // MARK: - IBACTIONS
  @IBAction func segmentedActions(_ sender: Any) {
    let section: Int = segmentedControl.selectedSegmentIndex
    scrollTo(section: section)
  }
  
  @IBAction func search(_ sender: Any) {
    searchController.searchBar.becomeFirstResponder()
  }
  
  // MARK: - SETUP AND PRIVATE METHODS
  private func setup() {
    // Navigation
    setupNavigationBar()
    // Segmented control basic setup
    segmentedControl.isEnabled = false
    segmentedControl.isHidden = true
    // Setup Viper Router
    CatalogRouter.createModule(view: self)
    // Setup SearchBar
    setupSearchController()
    // Setup TableView
    setupTableView()
  }
  
  private func scrollTo(section: Int) {
    let indexPath = IndexPath(row: 0, section: section)
    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
  }
  
  private func getItemAt(_ indexPath: IndexPath) -> Movie? {
    return presenter?.getItemAt(indexPath: indexPath)
  }
  
  private func setupTableView() {
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.estimatedRowHeight = cellHeight
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: identifier)
  }
  
  private func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = searchPlaceholder
    searchController.searchBar.sizeToFit()
    navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
  }
  
  private func updateSegmentedControl() {
    presenter?.setupSegmentedControl(control: &segmentedControl)
  }
  
  private func filterSearch(_ searchController: UISearchController) {
    guard let input = searchController.searchBar.text else { return }
    presenter?.filterSearch(input: input) {
      self.tableView.reloadData()
    }
  }
  
  private func showSearchResults(_ show: Bool) {
    presenter?.showSearchResults = show
    self.tableView.reloadData()
  }
  
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.tintColor = Colors().Main
    self.navigationController?.navigationBar.topItem?.title = self.titleNavigation
  }
}

extension CatalogViewController: CatalogViewProtocol {
  
  func loadMovies() {
    Loader.dismiss(view: loaderView)
    self.tableView.reloadData()
    updateSegmentedControl()
  }
  
  func showErrorMessage(_ message: String) {
    self.tableView.isHidden = true
    self.navigationController?.navigationBar.isHidden = true
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
    self.segmentedControl.selectedSegmentIndex = indexPath.section
    guard let movie = getItemAt(indexPath) else { return UITableViewCell() }
    let imageHelper: CellHelper = CellHelper()
    return imageHelper.setupCell(for: tableView, with: identifier, row: indexPath.row, data: movie, delegate: self)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let movie = getItemAt(indexPath) else { return }
    presenter?.showDetailView(for: movie, from: self)
    self.tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView,
      let font = fontSection else { return }
    header.textLabel?.font = font
    header.textLabel?.textColor = Colors().Main
    header.contentView.backgroundColor = UIColor.white
  }
}
// MARK: - SEARCHBAR Delegate
extension CatalogViewController: UISearchResultsUpdating, UISearchBarDelegate {
  
  func updateSearchResults(for searchController: UISearchController) {
    filterSearch(searchController)
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    showSearchResults(true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    showSearchResults(false)
    searchController.searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let show = presenter?.showSearchResults, !show {
       showSearchResults(true)
    }
    searchController.searchBar.resignFirstResponder()
  }
}

// MARK: - CELL Delegate Protocol
extension CatalogViewController: MovieTableViewCellDelegate {
  func showMovieTrailer() {
    print(#function)
  }
}
