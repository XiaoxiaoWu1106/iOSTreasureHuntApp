//
//  TreasureHuntingiOSTests.swift
//  TreasureHuntingiOSTests
//
//  Created by Xiaoxiao Wu on 22.8.2020.
//  Copyright © 2020 Xiaoxiao Wu. All rights reserved.
//

import XCTest
@testable import TreasureHuntingiOS

class MockedDBManager: DBManager {
    func saveSummary(summary: Summary) {
    }
    func loadSummaries(hunt: Hunt) -> [Summary] {
        return []
    }
    func loadHunts() -> [Hunt] {
        return []
    }
    func deleteHunt(hunt: Hunt) {
    }
    var isSaved = false
    func saveHunt(hunt: Hunt) {
        isSaved = true
    }
}

class TreasureHuntingiOSTests: XCTestCase {

    let dbManager = MockedDBManager()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let manager = HuntManager(dbManager: self.dbManager)
        XCTAssertFalse(self.dbManager.isSaved)
        let hunt = Hunt(identifier: "brook", title: "", description: "", author: "", lang: "", stages: [])
        manager.doSomething(hunt: hunt)
        XCTAssertTrue(self.dbManager.isSaved)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
