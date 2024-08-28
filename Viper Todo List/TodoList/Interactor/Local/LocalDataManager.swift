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
    func getUncompletedTodos(completion: @escaping (VtlTodoResult) -> Void)
    func saveTodo(todo: Todo) throws
}

class LocalDataManager: LocalDataManagerProtocol {
    
    func getUncompletedTodos(completion: @escaping (VtlTodoResult) -> Void) {
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
    
    func saveTodo(todo: Todo) throws {
        
        let viewContext = CoreDataManager.persistentContainer.viewContext
        if let todoEntity = NSEntityDescription.entity(forEntityName: "Todo", in: viewContext){
            let newTodo = Todo(entity: todoEntity, insertInto: viewContext)
            newTodo.name = todo.name
            newTodo.details = todo.details
            newTodo.completed = todo.completed
            newTodo.dateCreated = todo.dateCreated
            newTodo.dateCompleted = todo.dateCompleted
            try viewContext.save()
        }
        
        throw VtlError.CouldNotSaveObject
        
    }
}
