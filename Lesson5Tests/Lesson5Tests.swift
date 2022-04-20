//
//  Lesson5Tests.swift
//  Lesson5Tests
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import XCTest
@testable import Lesson5

class TestUserView: UserInputView {
    
    var title: String?
    var expectation: XCTestExpectation?
    
    func didGetUsers() {
        title = "test success"
        expectation?.fulfill()
    }
}

class Lesson5Tests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "Lesson5Tests")
    
    var userView: TestUserView!
    var networkService: NetworkService!
    var presenter: UserPresenter!
    
    override func setUpWithError() throws {
        super.setUp()
        userView = TestUserView()
        networkService = NetworkService()
        presenter = UserPresenter(view: userView, networkService: networkService)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        userView = nil
        networkService = nil
        presenter = nil
    }
    
    func testIsModuleIsNotNil() {
        XCTAssertNotNil(userView)
        XCTAssertNotNil(networkService)
        XCTAssertNotNil(presenter)
    }
    
    func testGettingUsers() {
        userView.expectation = expectation
        presenter.viewDidLoad()
        self.wait(for: [self.expectation], timeout: 5.0)
        XCTAssertEqual(self.userView.title, "test success")
    }
    
    func testGettingData() {
        if let data = networkService.getData(from: "https://jsonplaceholder.typicode.com/users") {
            print(data)
        } else {
            XCTFail()
        }
    }
    
    func testGettingUsersFromData() {
        if let data = networkService.getData(from: "https://jsonplaceholder.typicode.com/users") {
            networkService.parseFrom(data: data, type: [UserData].self) { result in
                switch result {
                case .success(let users):
                    print(users)
                case .failure(let error):
                    print(error)
                    XCTFail()
                }
            }
        } else {
            XCTFail()
        }
    }
}
