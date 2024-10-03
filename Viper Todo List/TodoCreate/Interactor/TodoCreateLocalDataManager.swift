//
//  TodoCreateLocalDataManager.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import Foundation
import CoreData

protocol TodoCreateLocalDataManagerProtocol {
    var responseHandler: TodoCreateLocalDataManagerResponseProtocol? { get set }
    func createTodo(todo: TodoModel) throws
}

protocol TodoCreateLocalDataManagerResponseProtocol {
    func didCreateTodo()
}

final class TodoCreateLocalDataManager: TodoCreateLocalDataManagerProtocol {
    
    var responseHandler: TodoCreateLocalDataManagerResponseProtocol?
    func createTodo(todo: TodoModel) throws {
        let viewContext = CoreDataManager.persistentContainer.viewContext
        if let todoEntity = NSEntityDescription.entity(forEntityName: "Todo", in: viewContext){
            let newTodo = Todo(entity: todoEntity, insertInto: viewContext)
            newTodo.setValue(todo.name, forKey: "name")
            newTodo.setValue(todo.details, forKey: "details")
            newTodo.setValue(todo.completed, forKey: "completed")
            newTodo.setValue(todo.priority, forKey: "priority")
            newTodo.setValue(todo.dateCreated, forKey: "dateCreated")
            newTodo.setValue(todo.dateCompleted, forKey: "dateCompleted")
        }
        
        do {
            try viewContext.save()
            responseHandler?.didCreateTodo()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            
            throw VtlError.CouldNotSaveObject
        }
    }
}
