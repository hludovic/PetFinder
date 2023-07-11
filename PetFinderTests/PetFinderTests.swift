//
//  PetFinderTests.swift
//  PetFinderTests
//
//  Created by Ludovic HENRY on 11/07/2023.
//

import XCTest
@testable import PetFinder

final class PetFinderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testNoDataIsLoaded_WhenLoadData_ThenAllPetsAround50kmIsLoaded() async throws {
        // Given
        _ = try await PreviewData.uploadMissingPets()
        try await Task.sleep(nanoseconds: 2_000_000_000)
    }


}
