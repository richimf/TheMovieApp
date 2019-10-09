//
//  APIClientMock.swift
//  TheMovieAppTests
//
//  Created by Richie on 08/10/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import TheMovieApp

class APIClientMock {
  var delegate: APIResponseProtocol?
  
  private let moviesJson: String = "{\"page\": 1, \"total_results\": 10000, \"total_pages\": 500,\"results\": [{\"popularity\": 625.548,\"vote_count\": 1349,\"video\": false,\"poster_path\": \"/v0eQLbzT6sWelfApuYsEkYpzufl.jpg\",\"id\": 475557,\"adult\": false,\"backdrop_path\": \"/f5F4cRhQdUbyVbB5lTNCwUzD6BP.jpg\",\"original_language\": \"en\",\"original_title\": \"Joker\",\"genre_ids\": [80, 18, 53], \"title\": \"Guasón\", \"vote_average\": 8.7, \"overview\": \"oscuro.\", \"release_date\": \"2019-10-04\"}]}"

  private let genresJson: String = "{\"genres\": [{  \"id\": 28,  \"name\": \"Acción\"}, {  \"id\": 12,  \"name\": \"Aventura\"}, {  \"id\": 16,  \"name\": \"Animación\"}, {  \"id\": 35,  \"name\": \"Comedia\"}, {  \"id\": 80,  \"name\": \"Crimen\"}, {  \"id\": 99,  \"name\": \"Documental\"}, {  \"id\": 18,  \"name\": \"Drama\"}, {  \"id\": 10751,  \"name\": \"Familia\"}, {  \"id\": 14,  \"name\": \"Fantasía\"}, {  \"id\": 36,  \"name\": \"Historia\"}, {  \"id\": 27,  \"name\": \"Terror\"}, {  \"id\": 10402,  \"name\": \"Música\"}, {  \"id\": 9648,  \"name\": \"Misterio\"}, {  \"id\": 10749,  \"name\": \"Romance\"}, {  \"id\": 878,  \"name\": \"Ciencia ficción\"}, {  \"id\": 10770,  \"name\": \"Película de TV\"}, {  \"id\": 53,  \"name\": \"Suspense\"}, {  \"id\": 10752,  \"name\": \"Bélica\"}, {  \"id\": 37,  \"name\": \"Western\"}]}"

}
extension APIClientMock: APIClientProtocol {
  
  func fetchMovieListOf(url: APIUrls, release: APIMovieParams, lang: MovieLanguage) {
    var movies: MovieResults?
    movies = Mapper<MovieResults>().map(JSONString: moviesJson)
    self.delegate?.fetchedResult(data: movies ?? MovieResults())
  }
  
  func fetchGenreListOf(url: APIUrls, release: APIMovieParams, lang: MovieLanguage) {
    var genres: Genres?
    genres = Mapper<Genres>().map(JSONString: genresJson)
    self.delegate?.fetchedGenres(data: genres ?? Genres(categories: []))
  }

}
