//
//  CoreDataManager.swift
//  Alcatraz Escape
//
//  Created by Carl Wainwright on 27/01/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    class var shared: CoreDataManager {
        struct Singleton {
            static let instance = CoreDataManager()
        }
        return Singleton.instance
    }
    
    func saveNameAndDOB (name: String, DOB: Date) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
         let managedContext = appDelegate.persistentContainer.viewContext
               
               let entity = NSEntityDescription.entity(forEntityName: "InmateDetails", in: managedContext)!
               let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(DOB, forKey: "dateOfBirth")
        
        do {
            try managedContext.save()
        } catch {
            let error = error as NSError
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllSavedData() {
        //Remove all data saved with coreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "InmateDetails", in: context)
        fetchRequest.includesPropertyValues = false
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                context.delete(result)
            }
            try context.save()
            
        } catch {
            
            print("fetch error -\(error.localizedDescription)")
        }
    }
    
    func fetchSavedData() -> [DataForInmateDetails]? {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InmateDetails")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var savedObjects: [DataForInmateDetails] = []
            
            objects.forEach { (savedObject) in
                savedObjects.append(DataForInmateDetails(object: savedObject))
            }
            
            return savedObjects
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func fetchIndividualData(savedObject: String) -> [String]? {
        //fetch 1 item from coredata
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequet = NSFetchRequest<NSManagedObject>(entityName: "InmateDetails")
        
        do {
            let fetchedResults = try managedContext.fetch(fetchRequet)
            
            var newArray = [String]()
            for item in fetchedResults {
                print (item.value(forKey: savedObject)!)
                newArray.append(item.value(forKey: savedObject) as! String)
                
            }
            return newArray
        } catch let error as NSError {
            print (error.description)
        }
        return nil
    }
    
    func update(object: String, updatedEntry: Any, name: String) {
        //Update data held in coredata
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "name = %@", name)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InmateDetails")
        fetchRequest.predicate = predicate
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            if let last = tasks.last {
                
                last.setValue(updatedEntry, forKey: object)
                
                do {
                    try managedContext.save()
                    
                } catch {
                    let error = error as NSError
                    fatalError("Could not save. \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print ("Could not fetch. \(error). \(error.userInfo)")
        }
    }

}
