//
//  DetailViewController.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
  
  // IBOUTLETS
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet private weak var segmentedControl: UISegmentedControl!
  @IBOutlet private weak var buttonSearch: UIBarButtonItem!
  @IBOutlet weak var filterButton: UIButton!
  
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
  let imageDownloader: ImageDownloader = ImageDownloader()
  
  // OVERRIDES
  override func viewDidLoad() {
    super.viewDidLoad()
    Animator.show(view: loaderView)
    setup()
    presenter?.loadMoviesData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tableView.reloadData()
  }
  
  // MARK: - IBACTIONS
  @IBAction func segmentedActions(_ sender: Any) {
    let section: Int = segmentedControl.selectedSegmentIndex
    scrollTo(section: section)
  }

  @IBAction func search(_ sender: Any) {
    searchController.searchBar.becomeFirstResponder()
  }
  
  @IBAction func presentFilterGenresView(_ sender: Any) {
    filterButton.bounce()
    presenter?.showFilterView(from: self)
  }
  
  // MARK: - SETUP AND PRIVATE METHODS
  private func setup() {
    // Setup filter button
    filterButton.asFlotatingButton()
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
    segmentedControl.isEnabled = !show
    self.tableView.reloadData()
  }
  
  private func setupNavigationBar() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.tintColor = Colors().Main
    self.navigationController?.navigationBar.topItem?.title = self.titleNavigation
  }
  
  private func reloadRowAt(_ indexPath: IndexPath) {
    self.tableView.beginUpdates()
    self.tableView.reloadRows( at: [indexPath], with: .fade)
    self.tableView.endUpdates()
  }

  private func scaleFilterButton(hide: Bool) {
     Animator.scaleWhenScrolling(view: filterButton, isScrolling: hide)
  }
}

extension CatalogViewController: CatalogViewProtocol {
  
  func loadMovies() {
    Animator.dismiss(view: loaderView)
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
    return presenter?.getNameForSection(section)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.getNumberOfItemsAt(section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    self.segmentedControl.selectedSegmentIndex = indexPath.section
    guard let movie = getItemAt(indexPath),
          let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieTableViewCell
      else { return UITableViewCell()}
    // GET IMAGE FROM LOCAL
    let key = getURL(of: movie)
    if let imageFromStorage = presenter?.getImageFromLocalStorage(key: key as String) {
      cell.setup(with: movie, image: imageFromStorage)
    } else {
      // DOWNLOAD IMAGE
      let imageDownloaded = imageDownloader.loadCompressedImage(of: movie) {
        self.reloadRowAt(indexPath)
      }
      cell.setup(with: movie, image: imageDownloaded)
    }
    cell.delegate = self
    return cell
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

  // SCALE FILTER BUTTON
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    scaleFilterButton(hide: false)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scaleFilterButton(hide: true)
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
  func showMovieTrailer(of movie: Movie) {
    presenter?.showVideoPreview(for: movie, from: self)
  }
}
