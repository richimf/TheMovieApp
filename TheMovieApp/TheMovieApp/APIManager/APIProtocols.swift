//
//  APIProtocols.swift
//  TheMovieApp
//
//  Created by Richie on 10/3/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import Foundation

protocol APIResponseProtocol {
  func getResult(data: MovieResults)
  func onFailure(_ error: Error)
}
