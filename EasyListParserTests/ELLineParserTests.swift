//
//  ELLineParserTests.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELLineParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicFilter() {
        // arrange
        let line = "http://example.org"
        let expected = ".*http://example\\.org.*"
        
        // act
        let entry: ELBlockerEntry?
        do {
            entry = try ELLineParser.parse(line)
        } catch _ {
            entry = nil
        }
        
        // assert
        XCTAssertEqual(expected, entry?.trigger.urlFilter)
    }
    
    func testComment() {
        // arrange
        let line = "! Title: EasyList"
        var thrown = false
        
        // act
        do {
            try ELLineParser.parse(line)
        } catch _ {
            thrown = true
        }
        
        // assert
        XCTAssert(thrown)
    }
    
    func testCssFilter() {
        // arrange
        let line = "nbcuni.com###promo1"
        let expected = ".*nbcuni\\.com.*"
        
        // act
        let entry: ELBlockerEntry?
        do {
            entry = try ELLineParser.parse(line)
        } catch _ {
            entry = nil
        }
        
        // assert
        XCTAssertEqual(expected, entry?.trigger.urlFilter)
        XCTAssertEqual("CssDisplayNone", entry?.action.type)
        XCTAssertEqual("#promo1", entry?.action.selector)
    }
    
    func testFilterOption() {
        // arrange
        let line = "domain$option"
        var thrown = false
        
        // act
        do {
            try ELLineParser.parse(line)
        } catch _ {
            thrown = true
        }
        
        // assert
        XCTAssert(thrown)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
