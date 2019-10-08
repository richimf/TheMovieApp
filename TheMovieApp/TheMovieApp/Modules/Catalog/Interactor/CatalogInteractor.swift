//
//  CatalogInteractor.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit

class CatalogInteractor: CatalogInteractorInputProtocol {
  
  // MARK: - VIPER
  weak var presenter: CatalogInteractorOutputProtocol?
  private let apiClient = APIClient()
  private var movieResults: MovieResults?
  
  // DATA
  private var popular: [Movie] = []
  private var topRated: [Movie] = []
  private var upcoming: [Movie] = []
  private(set) var sections: [Category] = []
  var genresCategories: [Genre] = []
  var genresFilteredIds: [Int] = []
  
  // CACHE
  var cacheDataManager: CacheDataManager = CacheDataManager()
  
  // FILTERS
  private var filteredData: [Movie] = []
  
  // MARK: - REQUEST DATA
  func fetchMoviesData() {
    if Connectivity.isConnectedToInternet {
      apiClient.delegate = self
      // Request Genres
      apiClient.fetchGenreListOf(url: .genreTV, release: .none, lang: .MX)
      apiClient.fetchGenreListOf(url: .genreMovie, release: .none, lang: .MX)
      // Request Movie and TV shows List
      apiClient.fetchMovieListOf(url: .movie, release: .popular,  lang: .MX)
      apiClient.fetchMovieListOf(url: .movie, release: .topRated, lang: .MX)
      apiClient.fetchMovieListOf(url: .movie, release: .upcoming, lang: .MX)
      apiClient.fetchMovieListOf(url: .tv, release: .popular,  lang: .MX)
      apiClient.fetchMovieListOf(url: .tv, release: .topRated, lang: .MX)
      apiClient.fetchMovieListOf(url: .tv, release: .upcoming, lang: .MX)
    } else {
      // Load from local storage
      let update: () -> Void = { self.presenter?.updateData() }
      loadFromLocalStorage(category: .popular, completion: update)
      loadFromLocalStorage(category: .topRated, completion: update)
      loadFromLocalStorage(category: .upcoming, completion: update)
    }
  }
  
  func loadFromLocalStorage(category: Category, completion: @escaping () -> Void) {
    let dataManager = DataManager()
    dataManager.retrieveMoviesData(from: category.rawValue) {
      if category == .popular  { self.popular = $0 }
      if category == .topRated { self.topRated = $0 }
      if category == .upcoming { self.upcoming = $0 }
      self.appendSection(category)
      completion()
    }
  }
  
  func getImageFromLocalStorage(key: String) -> UIImage? {
    // Get image From Local Storage
    var image: UIImage?
    if !Connectivity.isConnectedToInternet {
      let dataManager = DataManager()
      dataManager.retrieveImageDataFrom(key: key) { data in
        guard let data = data else { return }
        image =  UIImage(data: data)
      }
    }
    return image
  }
  
  // MARK: - FILTERING DATA
  func filterSearch(text: String) {
    if text.isEmpty {
      self.filteredData = []
      return
    }
    let allData: [[Movie]] = [popular, topRated, topRated]
    allData.forEach { movies in
      let results = filterArray(input: text, data: movies)
      if !results.isEmpty {
        self.filteredData = results
        return
      }
    }
  }
  
  private func filterArray(input: String, data: [Movie]) -> [Movie] {
    let results = data.filter {
      if let title = $0.title {
        return title.contains(input)
      }
      if let name = $0.name {
        return name.contains(input)
      }
      return false
    }
    return results
  }
  
  // MARK: - FILTERING BY GENRE
  func filterByGenre(_ ids: [Int]) {
    self.genresFilteredIds = ids
    if ids.isEmpty {
      self.filteredData = []
      return
    }
    let allData: [[Movie]] = [popular, topRated, topRated]
    allData.forEach { movies in
      let results = finterByGenre(ids, data: movies)
      if !results.isEmpty {
        self.filteredData = results
        return
      }
    }
  }
  
  private func finterByGenre(_ ids: [Int], data: [Movie]) -> [Movie] {
    let results = data.filter {
      if let movieIds = $0.genereIds {
        return movieIds.contains{ ids.contains($0) }
      }
      return false
    }
    return results
  }
  
  // MARK: - GET NUMBER OF ITEMS AT
  func getNumberOfItemsAt(_ index: Int, isFiltering: Bool) -> Int {
    return isFiltering ? filteredData.count : getNumberOfItems(index)
  }
  
  //TODO: CHANGE ALL THIS SWITCH STATEMENTS TO "STATE-PATTERN"
  private func getNumberOfItems(_ index: Int) -> Int {
    let section = sections[index]
    switch section {
    case .popular:
      return popular.count
    case .upcoming:
      return upcoming.count
    case .topRated:
      return topRated.count
    case .none:
      return 0
    }
  }
  
  // MARK: - GET DATA FROM OR ITEM AT
  func getItemAt(_ indexPath: IndexPath, isFiltering: Bool) -> Movie? {
    if indexPath.row < filteredData.count && isFiltering {
      return filteredData[indexPath.row]
    } else {
      return getItemAt(indexPath)
    }
  }
  
  private func getItemAt(_ indexPath: IndexPath) -> Movie? {
    let section = sections[indexPath.section]
    return getDataFrom(section: section, at: indexPath.row)
  }
  
  func getDataFrom(section: APIMovieParams, at row: Int) -> Movie? {
    switch section {
    case .popular:
      return popular[row]
    case .upcoming:
      return upcoming[row]
    case .topRated:
      return topRated[row]
    case .none:
      return nil
    }
  }
  
  func getSections() -> [String] {
    var output: [String] = []
    sections.forEach {
      switch $0 {
      case .popular:
        output.append(MovieCategories.popular.rawValue)
      case .upcoming:
        output.append(MovieCategories.upcoming.rawValue)
      case .topRated:
        output.append(MovieCategories.topRated.rawValue)
      case .none:
        break
      }
    }
    return output
  }
}

// MARK: - API RESPONSE
extension CatalogInteractor: APIResponseProtocol {
  
  func fetchedGenres(data: Genres) {
    let local = DataManager()
    data.categories.forEach { genre in
      if !genresCategories.contains(genre){
        self.genresCategories.append(genre)
        local.saveEntryOf(genre: genre)
      }
    }
  }
  
  func fetchedResult(data: MovieResults) {
    if let section = data.category, let movies = data.results {
      // Append section
      appendSection(section)
      // Store
      storeMovies(movies: movies, category: section)
      // Append elements to each section
      switch section {
      case .popular:
        self.popular.append(contentsOf: movies)
      case .upcoming:
        self.upcoming.append(contentsOf: movies)
      case .topRated:
        self.topRated.append(contentsOf: movies)
      case .none:
        break
      }
    }
    self.presenter?.updateData()
  }
  
  // PRIVATE METHODS
  private func appendSection(_ section: Category) {
    // Append section
    if !self.sections.contains(section) {
      self.sections.append(section)
    }
  }
  
  private func storeMovies(movies: [Movie], category: Category) {
    let dataManager = DataManager()
    movies.forEach {
      dataManager.saveEntryOf(movie: $0, category: category)
    }
  }
  
  // MARK: - ERROR RESPONSE
  func onFailure(_ error: Error) {
    presenter?.receivedError(error)
  }
}

