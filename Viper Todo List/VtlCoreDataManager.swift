//
//  CoreDataManager.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "EcsCoreData")
        container.loadPersistentStores(completionHandler: {description, error in
            if let error = error {
                print("Error setting up core data: \(error)")
            }
        })
        return container
    }()

}
