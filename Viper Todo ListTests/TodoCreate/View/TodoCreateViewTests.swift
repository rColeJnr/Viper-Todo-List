//
//  TodoCreateViewTests.swift
//  Viper Todo ListTests
//
//  Created by rColeJnr on 04/09/24.
//

import XCTest
@testable import Viper_Todo_List

final class TodoCreateViewTests: XCTestCase {
    
    var sut: TodoCreateView!
    
    override func setUpWithError() throws {
        sut = TodoCreateView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_createBtn_cannotCreateTodo() {
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.cannotCreateTodo(), true)
    }
    
    func test_createBtn_canCreateTodo() {
        sut.name.text = "Todo name"
        sut.descriptionTF.text = "Todo description"
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.cannotCreateTodo(), false)
    }
    
    func test_createBtn_shoudNotShowErrorView() {
        sut.name.text = "Todo name"
        sut.descriptionTF.text = "Todo description"
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertTrue(sut.errorView.isHidden)
    }
    
    func test_createBtn_shoudShowErrorView() {
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    func test_createBtn_shouldShowErrorView_whenMissingDescription() {
        sut.name.text = "Todo name"
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertFalse(sut.errorView.isHidden)
    }
    
    func test_createBtn_shouldShowErrorView_whenMissingName() {
        sut.descriptionTF.text = "Todo description"
        sut.createBtn.sendActions(for: .touchUpInside)
        XCTAssertFalse(sut.errorView.isHidden)
    }
}
