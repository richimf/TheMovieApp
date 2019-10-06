//
//  DataManager.swift
//  TheMovieApp
//
//  Created by Ricardo Montesinos on 10/6/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit
import CoreData

// MARK: - CORE DATA MANAGER
public class DataManager {
  
  typealias RetreiveMovies = (_ movies: [Movie])->Void
  
  init() {}
  
  // MARK: - SAVE DATA
  func saveEntryOf(movie: Movie, category: Category) {
    // Get context
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext

    // Mapping
    let resultEntity = CDResult(context: managedContext)
    let movieEntity = CDMovie(context: managedContext)
    movieEntity.id = Int32(movie.id ?? 0)
    movieEntity.name = movie.name
    movieEntity.title = movie.title
    movieEntity.originalTitle = movie.originalTitle
    movieEntity.backdropPath = movie.backdropPath
    movieEntity.overview = movie.overview
    movieEntity.rating = movie.rating ?? 0.0
    movieEntity.voteCount = Int32(movie.voteCount ?? 0)
    movieEntity.posterPath = movie.posterPath
    movieEntity.category = category.rawValue
    
    // Assing to corresponding storage
    if category == .popular {
      resultEntity.addToPopular(movieEntity)
    }
    if category == .topRated {
      resultEntity.addToTopRated(movieEntity)
    }
    if category == .upcoming {
      resultEntity.addToUpcoming(movieEntity)
    }
    // Save
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  func saveEntryOf(genre: Genre) {
    // Get context
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let genreEntity = CDGenre(context: managedContext)
    // Mapping
    genreEntity.id = Int64(genre.id)
    //genreEntity.name = genre.name
    // Save
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  // MARK: - RETREIVE DATA
  func retrieveMoviesData(from category: String, completion: @escaping RetreiveMovies) {
    // Context
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    // Output
    var output: [Movie] = []
    
    // Fetch data
    let entity = CDResult(context: managedContext)
    let entityName = entity.getEntityName()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    do {
      let results = try managedContext.fetch(fetchRequest)
      results.forEach { result in
        let allResults = result as? CDResult
        var movies: [CDMovie] = []
        // Get movies according to category
        let section = getCategoryKeyFrom(name: category)
        if section == .popular {
          movies = allResults?.popular?.allObjects as? [CDMovie] ?? []
        }
        if section == .topRated {
          movies = allResults?.topRated?.allObjects as? [CDMovie] ?? []
        }
        if section == .upcoming {
          movies = allResults?.upcoming?.allObjects as? [CDMovie] ?? []
        }
        //Append all movies
        if !movies.isEmpty {
          movies.forEach { movie in
            output.append(mapMovie(data: movie, category: section, genres: nil))
          }
        }
      }
      //Return Output
      completion(output)
    } catch {
      print(error)
    }
  }
  
  // Movie MAPPING
  private func mapMovie(data: CDMovie, category: Category, genres: [Int]?) -> Movie {
    return Movie(id: Int(data.id),
                 originalTitle: data.originalTitle,
                 title: data.title,
                 name: data.name,
                 overview: data.overview,
                 posterPath: data.posterPath,
                 popularity: data.popularity,
                 voteCount: Int(data.voteCount),
                 rating: data.rating,
                 backdropPath: data.backdropPath,
                 releaseDate: data.releaseDate,
                 genereIds: genres,
                 posterImage: data.posterImage,
                 backdropImage: data.backdropImage,
                 category: category)
  }
  
  func updateData() {
    // Context
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let cdMovie = CDMovie()
    let entityName = cdMovie.getEntityName()
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
    fetchRequest.predicate = NSPredicate(format: "name = %@", "Test name 5")
    do {
      let test = try managedContext.fetch(fetchRequest)
      guard let objectUpdate = test[0] as? NSManagedObject else { return }
      objectUpdate.setValue("richie", forKey: "name")
      do {
        try managedContext.save()
      } catch {
        print(error)
      }
    } catch {
      print(error)
    }
  }
  
}
