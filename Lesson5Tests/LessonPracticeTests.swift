//
//  PracticeLessonTest.swift
//  Lesson5Tests
//
//  Created by Karakhanyan Tigran on 20.04.2022.
//

import XCTest
@testable import Lesson5

class PracticeLessonTest: XCTestCase {
    
    var sut: NetworkService2<MockNetworkClient<Item>>!
    var client: MockNetworkClient<Item>!
    
    override func setUpWithError() throws {
        super.setUp()
        
        client = MockNetworkClient<Item>()
        sut = NetworkService2(client: client)
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        client = nil
        sut = nil
    }
    
    func testServiceCanReceiveResult() {
        let expectedItem = Item(name: "test")
        var resultItem: Item?
        client.stubResponse = expectedItem
        
        sut.fetchItem(at: 0) { result in
            resultItem = try? result.get()
        }
        XCTAssertEqual(expectedItem.name, resultItem?.name)
    }
    
    func testNetworkItemRequest() {
        let params = ItemRequestParams(index: 0)
        client.stubResponse = Item(name: "John")
        client.networkRequest(params: params) { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                XCTFail()
            }
        }
    }
}
