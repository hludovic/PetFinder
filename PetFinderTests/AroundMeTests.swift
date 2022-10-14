//
//  AroundMeTests.swift
//  PetFinderTests
//
//  Created by Ludovic HENRY on 26/09/2022.
//

import XCTest
@testable import PetFinder

final class AroundMeTests: XCTestCase {
    
    func testNoDataIsLoaded_WhenLoadData_ThenAllPetsAround50kmIsLoaded() async throws {
        // Given
        let aroundDataManager = AroundMeData()
        _ = try await PreviewMockedData.uploadMissingPets()
        try await Task.sleep(nanoseconds: 2_000_000_000)
        
        // When
        let myLocation = PreviewMockedData.myLocation
        await aroundDataManager.loadData(from: myLocation)
        
        // Then
        XCTAssertEqual(aroundDataManager.petsAround.count, 3)
    }
}
