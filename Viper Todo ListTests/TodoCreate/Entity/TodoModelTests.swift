//
//  TodoModelTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoModelTests: XCTestCase {

    private var testTodo: TodoModel!
    private var dateCreated: Date!
    private let formatter = DateFormatter()
    override func setUpWithError() throws {
        formatter.dateFormat = "dd'-'MM'-'yyyy"
        dateCreated = formatter.date(from: "26-08-2024")!
        testTodo = TodoModel(name: "Name", details: "Details", completed: true, dateCreated: dateCreated, dateCompleted: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_init_createTodoItem() {
        
        XCTAssertEqual(testTodo.name, "Name")
        XCTAssertEqual(testTodo.details, "Details")
        XCTAssertEqual(testTodo.completed, true)
        XCTAssertEqual(testTodo.dateCreated, dateCreated)
        XCTAssertEqual(testTodo.dateCompleted, nil)
    }
    
    func test_init_whenGivenDateCompleted_setsDateCompleted() {
        let dummyDateCompleted: Date? = formatter.date(from: "06-09-2024")
        testTodo.dateCompleted = dummyDateCompleted
        var dateCompleted: Date!
        
        do {
            dateCompleted = try XCTUnwrap(testTodo.dateCompleted)
        } catch {
            
        }
        
        XCTAssertEqual(testTodo.dateCompleted, dateCompleted)
    }

}
