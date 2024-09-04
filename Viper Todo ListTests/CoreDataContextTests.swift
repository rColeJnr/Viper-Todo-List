//
//  CoreDataContext.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import CoreData

var sharedTestContext: NSManagedObjectContext = {
    // Swift is smart enough to execute this only once
    let container = NSPersistentContainer(name: "VtlCoreData")
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    container.loadPersistentStores(completionHandler: { (description, error) in
        if let error = error {
            fatalError("Failed to load store for test: \(error)")
        }
    })
    return container.newBackgroundContext()
}()


public extension NSManagedObject {
    convenience init(testContext: NSManagedObjectContext?) {
        let context = testContext ?? sharedTestContext
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}

