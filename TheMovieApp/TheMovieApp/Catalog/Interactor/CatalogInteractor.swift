//
//  CatalogInteractor.swift
//  TheMovieApp
//
//  Created by Richie on 10/1/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

class CatalogInteractor: CatalogInteractorInputProtocol {
  
  // MARK: - VIPER
  weak var presenter: CatalogInteractorOutputProtocol?
  private let apiClient = APIClient()
  private var movieResults: MovieResults?
  
  // DATA
  private var popular: [Movie] = []
  private var topRated: [Movie] = []
  private var upcoming: [Movie] = []
  private(set) var sections: [Release] = []

  // FILTERS
  private var allData: [Movie] = []
  private var filteredData: [Movie] = []
  
  func fetchMoviesData() {
    apiClient.delegate = self
    apiClient.fetchMovieListOf(url: .movie, release: .popular,  lang: .MX)
    apiClient.fetchMovieListOf(url: .movie, release: .topRated, lang: .MX)
    apiClient.fetchMovieListOf(url: .movie, release: .upcoming, lang: .MX)
  }
  
  private func appendAllData() {
    allData.append(contentsOf: popular)
    allData.append(contentsOf: topRated)
    allData.append(contentsOf: upcoming)
  }
  
  func filterSearch(text: String) {
    filteredData = allData.filter { $0.title?.contains(text) ?? false }
  }
  
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
    }
  }
  
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
      }
    }
    return output
  }

}
// MARK: - API RESPONSE
extension CatalogInteractor: APIResponseProtocol {
  func fetchedResult(data: MovieResults) {
    if let section = data.release, let movies = data.results {
      // Append section
      if !self.sections.contains(section) {
        self.sections.append(section)
      }
      // Append elements to each section
      switch section {
      case .popular:
        self.popular.append(contentsOf: movies)
      case .upcoming:
        self.upcoming.append(contentsOf: movies)
      case .topRated:
        self.topRated.append(contentsOf: movies)
      }
    }
    presenter?.updateData()
    appendAllData()
  }
  
  func onFailure(_ error: Error) {
    presenter?.receivedError(error)
  }
}

