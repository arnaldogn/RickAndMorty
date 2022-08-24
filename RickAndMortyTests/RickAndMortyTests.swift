//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//
//  Created by Arnaldo Gnesutta on 24/8/22.
//

import XCTest
@testable import RickAndMorty

final class RickAndMortyTests: XCTestCase {

    func testCharacter_AfterDecodingFromJsonExample_ShouldNotBeNull() {
        
        guard let data = Character.jsonExample.data(using: .utf8) else {
            return XCTAssertThrowsError("No data")
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Constants.dateFormat)
        let character = try? decoder.decode(Character.self, from: data)
        XCTAssertNotNil(character)
    }

}
