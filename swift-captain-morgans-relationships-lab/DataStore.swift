//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Ugowe on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    var pirates: [Pirate] = []
    var ships: [Ship] = []
    
    static let sharedDataStore = DataStore()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func fetchData ()
    {
        var error: NSError? = nil
        
        let pirateRequest = NSFetchRequest(entityName: "Pirate")
        
        let createdAtSorter = NSSortDescriptor(key: "name", ascending: true)
        
        pirateRequest.sortDescriptors = [createdAtSorter]
        
        do {
            pirates = try managedObjectContext.executeFetchRequest(pirateRequest) as! [Pirate]
        } catch let nserror1 as NSError {
            error = nserror1
            pirates = []
        }
        
        if pirates.count == 0 {
            generateDate()
        }
        
    }
    
    func generateDate ()
    {
        let pirate1: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        
        pirate1.name = "Blackbeard"
        
        let pirate2: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        
        pirate2.name = "Jolly Rogers"
        
        let pirate3: Pirate = NSEntityDescription.insertNewObjectForEntityForName("Pirate", inManagedObjectContext: managedObjectContext) as! Pirate
        
        pirate3.name = "Christopher Columbus"
        
        let ship1: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship1.name = "Blackship"
        ship1.pirate = pirate1
        
        let ship2: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship2.name = "Black Mast"
        ship2.pirate = pirate1
        
        let ship3: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship3.name = "Steamer"
        ship3.pirate = pirate2
        
        let ship4: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship4.name = "Old Ironside"
        ship4.pirate = pirate2
        
        let ship5: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship5.name = "Nina"
        ship5.pirate = pirate3
        
        let ship6: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship6.name = "Pinta"
        ship6.pirate = pirate3
        
        let ship7: Ship = NSEntityDescription.insertNewObjectForEntityForName("Ship", inManagedObjectContext: managedObjectContext) as! Ship
        
        ship7.name = "Santa Maria"
        ship7.pirate = pirate3
        
        
        let engine1: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine1.propulsion = "gas"
        ship1.engine = engine1
        
        let engine2: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine2.propulsion = "electric"
        ship2.engine = engine2
        
        let engine3: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine3.propulsion = "sail"
        ship3.engine = engine3
        
        let engine4: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine4.propulsion = "gas"
        ship4.engine = engine4
        
        let engine5: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine5.propulsion = "water"
        ship5.engine = engine5
        
        let engine6: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine6.propulsion = "electric slide"
        ship6.engine = engine6
        
        
        let engine7: Engine = NSEntityDescription.insertNewObjectForEntityForName("Engine", inManagedObjectContext: managedObjectContext) as! Engine
        
        engine7.propulsion = "electric"
        ship7.engine = engine7
        
        
    
        saveContext()
        fetchData()
    }
    
    // MARK: - Core Data stack
    // Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("swift_captain_morgans_relationships_lab.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: Application's Documents directory
    // Returns the URL to the application's Documents directory.
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
}