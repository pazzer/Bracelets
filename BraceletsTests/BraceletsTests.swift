//
//  BraceletsTests.swift
//  BraceletsTests
//
//  Created by Paul Patterson on 15/07/2024.
//

import XCTest
@testable import Bracelets

final class BraceletsTests: XCTestCase {
            
    let ints = [0, 8, 9, 13, 27, 
                29, 32, 33, 35, 36,
                45, 48, 53, 56, 57,
                60, 68, 73, 75, 89,
                95]

    func testIntFindingExactMatches() throws {
        var index = try XCTUnwrap(ints.indexOfNearestMatch(32, matchRule: .closest))
        XCTAssertEqual(index, 6)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(0, matchRule: .closest))
        XCTAssertEqual(index, 0)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(89, matchRule: .closest))
        XCTAssertEqual(index, 19)

        index = try XCTUnwrap(ints.indexOfNearestMatch(9, matchRule: .closest))
        XCTAssertEqual(index, 2)
    }
    
    func testIntFindingClosestMatches() throws {
        var index = try XCTUnwrap(ints.indexOfNearestMatch(30, matchRule: .closest))
        XCTAssertEqual(index, 5)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(31, matchRule: .closest))
        XCTAssertEqual(index, 6)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(64, matchRule: .closest))
        XCTAssertEqual(index, 15)

        index = try XCTUnwrap(ints.indexOfNearestMatch(94, matchRule: .closest))
        XCTAssertEqual(index, 20)
    }
    
    
    func testIntFindingFirstAboveMatches() throws {
        var index = try XCTUnwrap(ints.indexOfNearestMatch(30, matchRule: .firstBelow))
        XCTAssertEqual(index, 5)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(31, matchRule: .firstBelow))
        XCTAssertEqual(index, 5)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(88, matchRule: .firstBelow))
        XCTAssertEqual(index, 18)

        index = try XCTUnwrap(ints.indexOfNearestMatch(65, matchRule: .firstBelow))
        XCTAssertEqual(index, 15)
    }
    
    func testIntFindingFirstBelowMatches() throws {
        var index = try XCTUnwrap(ints.indexOfNearestMatch(65, matchRule: .firstAbove))
        XCTAssertEqual(index, 16)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(88, matchRule: .firstAbove))
        XCTAssertEqual(index, 19)
        
        index = try XCTUnwrap(ints.indexOfNearestMatch(6, matchRule: .firstAbove))
        XCTAssertEqual(index, 1)

        index = try XCTUnwrap(ints.indexOfNearestMatch(90, matchRule: .firstAbove))
        XCTAssertEqual(index, 20)
    }
    
    func testOther() throws {
        
    }

}
