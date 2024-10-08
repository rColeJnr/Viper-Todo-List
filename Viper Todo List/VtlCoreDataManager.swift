//
//  CoreDataManager.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import CoreData

class CoreDataManager {
    
    static let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "VtlCoreData")
        container.loadPersistentStores(completionHandler: {description, error in
            if let error = error {
                print("Error setting up core data: \(error)")
            }
        })
        return container
    }()
}
