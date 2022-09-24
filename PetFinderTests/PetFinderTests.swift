//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Ludovic HENRY on 19/09/2022.
//

import XCTest
@testable import PetFinder

final class PetFinderTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
        
        
        let pet = PetTest()
//        _ = try await pet.uploadPets()
        try await pet.makeAllPetsMissing()
//        let mypets = try await pet.fetchMyPets()
//        print("AAA")
//        print(mypets.count)
        
        let alerts = try await pet.fetchMyAlerts()
        print(alerts.count)
        
//        let myPets = try await pet.fetchMyPets()
//        for myPet in myPets {
//            try await pet.isLost(pet: myPet.id)
//        }
    }
}
