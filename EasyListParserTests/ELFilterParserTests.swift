//
//  ELFilterParserTests.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/22/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELFilterParserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyFilter() {
        // arrange
        let filter = ""
        let good = "http://example.org"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
    }
    
    func testBasicFilter1() {
        // arrange
        let filter = "example"
        let good = "http://example.org"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testBasicFilter2() {
        // arrange
        let filter = "example.org/banner*.gif"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testBasicFilter3() {
        // arrange
        let filter = "example.org/*"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testBasicFilter4() {
        // arrange
        let filter = "&adpageurl="
        let good = "http://example.org?x=A&adpageurl=B"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testCompound1() {
        // arrange
        let filter = "||ymads.com^"
        let good = "http://ymads.com/xyz"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testCompound2() {
        // arrange
        let filter = "||xxxxsextube.com/*.html"
        let good = "http://xxxxsextube.com/xyz.html"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testBoa1() {
        // arrange
        let filter = "||example.org/*"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testBoa2() {
        // arrange
        let filter = "|http://example.org/*"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testEoa1() {
        // arrange
        let filter = "example.org/*|"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testEoa2() {
        // arrange
        let filter = "http://example.org/banner*.gif|"
        let good = "http://example.org/banner123.gif"
        let bad = "http://google.com"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testSeparator1() {
        // arrange
        let filter = "^example.com^"
        let good = "http://example.com:8000/"
        let bad = "http://example.com.ar/"
        
        // act
        let regex = ELFilterParser.parse(filter)
        
        // assert
        XCTAssert(good.match(regex))
        XCTAssert(!bad.match(regex))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
