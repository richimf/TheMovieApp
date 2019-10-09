//
//  APIClientTests.swift
//  TheMovieAppTests
//
//  Created by Richie on 08/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import XCTest
@testable import TheMovieApp

class InteractorTests: XCTestCase {
  
  private var apiClient: APIClientMock?
  
  override func setUp() {
    self.apiClient = APIClientMock()
    self.apiClient?.delegate = self
  }
  
  override func tearDown() {
    self.apiClient = nil
  }
  
  func testGetMovies() {
    self.apiClient?.fetchMovieListOf(url: .genreTV, release: .none, lang: .MX)
  }
  
  func testGetGenres() {
    self.apiClient?.fetchGenreListOf(url: .genreTV, release: .none, lang: .MX)
  }
}
extension InteractorTests: APIResponseProtocol {
  func fetchedResult(data: MovieResults) {
    guard let resutls = data.results else {
      XCTFail()
      return
    }
    XCTAssert(!resutls.isEmpty, "Error")
  }
  
  func fetchedGenres(data: Genres) {
    XCTAssert(!data.categories.isEmpty, "Error")
  }
  
  func onFailure(_ error: Error) {
    print(error)
  }
}
