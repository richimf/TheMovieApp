//
//  DataManager.swift
//  TheMovieApp
//
//  Created by Richie on 10/6/19.
//  Copyright © 2019 Rappi. All rights reserved.
//

import UIKit
import CoreData

public class DataManager {
  
  init() {}
  
  func createData() {
    // Get context
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    // Perform data creation
    for i in 1...5 {
      let movieEntity = CDMovie(context: managedContext)
      movieEntity.name = "Test name \(i)"
    }
    // Save
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }
  
  func retrieveData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let cdMovie = CDMovie()
    let entityName = cdMovie.getEntityName()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    do {
      guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else { return }
      result.forEach { data in
        print(data.value(forKey: "name") as! String)
      }
    } catch {
      print("Failed")
    }
  }
  
  func updateData() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let cdMovie = CDMovie()
    let entityName = cdMovie.getEntityName()
    let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: entityName)
    // let resultPredicate = NSPredicate(format: "name contains[c] %@", searchText)
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

// MARK: - CORE DATA ENTITY NAMES
// Protocols to help get coredata entity names
protocol EntityNameProtocol: class {
  func getEntityName() -> String
}
extension EntityNameProtocol where Self: NSManagedObject {
  func getEntityName() -> String {
    let thisType = type(of: self)
    return String(describing: thisType)
  }
}
extension CDMovie: EntityNameProtocol {
  //  enum Names {
  //    case backdropPath(String) = String(describing: backdropPath.self)
  //  }
  //
  public func backdropPathName() {
    //    backdropPath: String?
    //    id: Int16
    //    name: String?
    //    originalTitle: String?
    //    overview: String?
    //    rating: Float
    //    releaseDate: String?
    //    title: String?
    //    voteCount: Int64
    //    posterPath: String?
    //    posterImage: Data?
    //    backdropImage: Data?
    //    genres: NSSet?
  }
}

extension CDGenre: EntityNameProtocol {
  //  @NSManaged public var id: Int64
  //  @NSManaged public var name: String?
  //  @NSManaged public var movie: CDMovie?
}
