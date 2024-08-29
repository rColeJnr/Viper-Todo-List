//
//  DummyJsonApi.swift
//  Viper Todo List
//
//  Created by rColeJnr on 28/08/24.
//

import Foundation
import CoreData

protocol RemoteManagerProtocol {
    var remoteRequestHandler: RemoteManagerResponseProtocol? { get set }
    
    // Interactor -> RemoteManager
    func fetchTodos(completion: @escaping (VtlTodoResult) -> Void)
}

protocol RemoteManagerResponseProtocol {
    // RemoteManager -> Interactor
    // Interactor -> Presenter
    func didGetCompletedTodos(_ todos: [Todo])
    func didGetUncompletedTodos(_ todos: [Todo])
    func onError(_ error: Error)
}

class RemoteDataManager: RemoteManagerProtocol {
    var remoteRequestHandler: RemoteManagerResponseProtocol?
    
    private let baseUrl = "https://dummyjson.com/todos"
   
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchTodos(completion: @escaping (VtlTodoResult) -> Void) {
        guard let url = URL(string: baseUrl) else {
            fatalError("Failed to create dummyjson url")
        }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request, completionHandler: { (data, _, error) -> Void in
            //                 Print json response
            //                if let jsonData = data {
            //                    if let josnString = String(data: jsonData, encoding: .utf8) {
            //                        print(josnString)
            //                    } else if let requestError = error {
            //                            print("error fetching: \(requestError)")
            //                        }
            //                } else {
            //                    print("unxecpected error")
            //                }
            
            self.processTodosRequest(data: data, error: error, completion: { result in
                OperationQueue.main.addOperation {
                    switch result {
                    case .success(let todos):
                        self.remoteRequestHandler?.didGetCompletedTodos(todos.filter({it in it.completed}))
                        self.remoteRequestHandler?.didGetUncompletedTodos(todos.filter({it in !it.completed}))
                    case .failure(let error):
                        self.remoteRequestHandler?.onError(error)
                    }
                }
            })
        })
        task.resume()
    }
    
    private func processTodosRequest(data: Data?, error: Error?, completion: @escaping (VtlTodoResult) -> Void) {
        guard let jsonData = data else {
            return completion(.failure(error!))
        }
        
        CoreDataManager.persistentContainer.performBackgroundTask { context in
            let result = self.serializeDummyTodo(fromJson: jsonData, into: context)
            
            do {
                try context.save()
            } catch {
                completion(.failure(VtlError.FailedToSaveToCoreData))
                return
            }
            
            switch result {
            case .success(let array):
                let todoIds = array.map { return $0.objectID }
                let viewContext =  CoreDataManager.persistentContainer.viewContext
                let viewContextTodos = todoIds.map { return viewContext.object(with: $0) } as! [Todo]
                completion(.success(viewContextTodos))
            case .failure:
                completion(result)
            }
            
        }
    }
    
    private func serializeDummyTodo(fromJson json: Data, into context: NSManagedObjectContext) -> VtlTodoResult {
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: json)
            guard
                let jsonDictionary = jsonObj as? [AnyHashable:Any],
                let dummyTodos = jsonDictionary["todos"] as? [[String:Any]] else {
                // The json structure doenst match our expectations
                return .failure(VtlError.InvalidJsonData)
            }
            
            var todos = [Todo]()
            for todoJson in dummyTodos {
                if let todo = RemoteDataManager.todo(fromJson: todoJson, into: context) {
                    todos.append(todo)
                }
            }
            
            if todos.isEmpty && !dummyTodos.isEmpty {
                // we weren't able to parse any of the dummyjsonTodos to todos
                return .failure(VtlError.FailedToParse)
            }
            
            return .success(todos)
               
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func todo(fromJson json: [String:Any], into context: NSManagedObjectContext) -> Todo? {
        guard
            let name = json["todo"] as? String,
            let completed = json["completed"] as? Bool else {
            return nil
        }
        
        // Construct coredata Todo
        var todo: Todo!
        context.performAndWait({
            todo = Todo(context: context)
            todo.name = name
            todo.completed = completed
        })
        return todo
    }
}

enum VtlError: Error {
    case InvalidJsonData
    case FailedToParse
    case FailedToSaveToCoreData
    case CouldNotSaveObject
}
