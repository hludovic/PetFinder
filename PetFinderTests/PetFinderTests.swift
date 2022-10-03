//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import XCTest
@testable import PetFinder
import CoreLocation

final class PetFinderTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func setUp() async throws {
        _ = try await PreviewMockedData.uploadMissingPets()
        try await Task.sleep(nanoseconds: 3_000_000_000)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() async throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let aroundDataManager = AroundMeData()
        let myLocation = PreviewMockedData.myLocation
        await aroundDataManager.loadData(from: myLocation)
        XCTAssertEqual(aroundDataManager.petsAround.count, 3)
    }
}
