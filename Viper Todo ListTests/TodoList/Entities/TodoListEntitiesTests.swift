//
//  TodoListEntitiesTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoListEntitiesTests: XCTestCase {

    var sut: [TodoListSectionType]!
    override func setUpWithError() throws {
        sut = TodoListSectionType.allCases
        
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_todoListSectionTypeOrder() {
        XCTAssertEqual(sut[0], .LoadingView)
        XCTAssertEqual(sut[1], .ErrorView)
        XCTAssertEqual(sut[2], .inProgressRow)
        XCTAssertEqual(sut[3], .inProgress)
        XCTAssertEqual(sut[4], .EmptyInProgress)
        XCTAssertEqual(sut[5], .completedRow)
        XCTAssertEqual(sut[6], .completed)
        XCTAssertEqual(sut[7], .EmptyCompleted)
        XCTAssertEqual(sut[8], .createNew)
    }
  
}
