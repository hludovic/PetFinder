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
        let aroundDataManager = AroundMeVM()
        aroundDataManager.location = PreviewMockedData.myLocation
        _ = try await PreviewMockedData.uploadMissingPets()
        try await Task.sleep(nanoseconds: 2_000_000_000)

        // When
        await aroundDataManager.loadData()

        // Then
        XCTAssertEqual(aroundDataManager.petsAround.count, 3)
    }

    func testNewTest() {
//        print("Start")
//        var dateComponent = DateComponents()
//        dateComponent.day = 12
//        dateComponent.month = 7
//        dateComponent.year = 1983
//        let calendar = Calendar(identifier: .gregorian)
//        let viewModel = EditPetVM()
//        viewModel.breed = "DogBreed"
//        viewModel.date = calendar.date(from: dateComponent)!
//        viewModel.name  = "DogName"
//        viewModel.petType = PetLost.PetType.dog
//        viewModel.gender = PetLost.Gender.male
//
//        viewModel.canSave()
    }
}
