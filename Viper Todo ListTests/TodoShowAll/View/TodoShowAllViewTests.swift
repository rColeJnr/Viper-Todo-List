//
//  TodoShowAllViewTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoShowAllViewTests: XCTestCase {

    var sut: TodoShowAllView!
    var todoList: [Todo]!
    override func setUpWithError() throws {
        todoList = []
        sut = TodoShowAllView()
    }

    override func tearDownWithError() throws {
        todoList = nil
        sut = nil
    }
    
    func test_shouldNotShowEmptyView() {
        todoList.append(Todo(testContext: nil))
        sut.todoList = todoList
        sut.showEmptyView()
        XCTAssertFalse(sut.isEmptyViewHidden())
        
    }
    
    func test_shouldShowEmptyView() {
        sut.todoList = todoList
        sut.showEmptyView()
        XCTAssertTrue(sut.isEmptyViewHidden())
    }
    
    func test_indicatorViewShouldAnimate() {
        sut.startAnimatingIndicatorView()
        XCTAssertTrue(sut.isIndicatorViewAnimating())
    }
    
    func test_indicatorViewShouldNotAnimate() {
        sut.stopAnimatingIndicatorView()
        XCTAssertFalse(sut.isIndicatorViewAnimating())
    }


}
