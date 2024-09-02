//
//  LocalDataManager.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import CoreData

protocol LocalDataManagerProtocol {
    // Interactor -> LocalDataManager
    func getCompletedTodos(completion: @escaping (VtlTodoResult) -> Void)
    func getInProgressTodos(completion: @escaping (VtlTodoResult) -> Void)
}

class LocalDataManager: LocalDataManagerProtocol {
    
    func getInProgressTodos(completion: @escaping (VtlTodoResult) -> Void) {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortByDateCreated = NSSortDescriptor(key: #keyPath(Todo.dateCreated), ascending: false)
        let predicate = NSPredicate(format: "\(#keyPath(Todo.completed)) == \(false)")
        
        fetchRequest.sortDescriptors = [sortByDateCreated]
        fetchRequest.predicate = predicate
        
        let viewContext = CoreDataManager.persistentContainer.viewContext
        viewContext.perform {
            do {
                let todos = try viewContext.fetch(fetchRequest)
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
    }
        
    func getCompletedTodos(completion: @escaping (VtlTodoResult) -> Void) {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortByDateCreated = NSSortDescriptor(key: #keyPath(Todo.dateCreated), ascending: false)
        let predicate = NSPredicate(format: "\(#keyPath(Todo.completed)) == \(true)")
        
        fetchRequest.sortDescriptors = [sortByDateCreated]
        fetchRequest.predicate = predicate
        
        let viewContext = CoreDataManager.persistentContainer.viewContext
        viewContext.perform {
            do {
                let todos = try viewContext.fetch(fetchRequest)
                completion(.success(todos))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
