//
//  Todo+CoreDataProperties.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var completed: Bool
    @NSManaged public var dateCreated: Date?
    @NSManaged public var dateCompleted: Date?

}

extension Todo : Identifiable {

}
