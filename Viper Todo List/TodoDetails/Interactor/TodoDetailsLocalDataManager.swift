//
//  TodoDetailsLocalDataManager.swift
//  Viper Todo List
//
//  Created by rColeJnr on 01/09/24.
//

import CoreData

protocol TodoDetailsLocalDataManagerProtocol {
    var responseHandler: TodoDetailsLocalDataManagerResponseProtocol? { get set }
    
    func deleteTodo(todo: Todo)
    func updateTodo(todo: Todo)
    
}

protocol TodoDetailsLocalDataManagerResponseProtocol {
    func didDeleteTodo()
    func didUpdateTodo()
}

final class TodoDetailsLocalDataManager: TodoDetailsLocalDataManagerProtocol {
    var responseHandler: TodoDetailsLocalDataManagerResponseProtocol?
    
    func deleteTodo(todo: Todo) {
        let viewContext = CoreDataManager.persistentContainer.viewContext
        
        do {
            viewContext.delete(todo)
            try viewContext.save()
            responseHandler?.didDeleteTodo()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func updateTodo(todo: Todo) {
        let viewContext = CoreDataManager.persistentContainer.viewContext
       
        todo.setValue(todo.name, forKey: "name")
        todo.setValue(todo.details, forKey: "details")
        todo.setValue(todo.completed, forKey: "completed")
        todo.setValue(todo.dateCompleted, forKey: "dateCompleted")
    
        do {
            try viewContext.save()
            responseHandler?.didUpdateTodo()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
