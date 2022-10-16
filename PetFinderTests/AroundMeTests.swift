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
        aroundDataManager.location = PreviewMockedData.myLocation
        _ = try await PreviewMockedData.uploadMissingPets()
        try await Task.sleep(nanoseconds: 2_000_000_000)

        // When
        await aroundDataManager.loadData()

        // Then
        XCTAssertEqual(aroundDataManager.petsAround.count, 3)
    }
}
