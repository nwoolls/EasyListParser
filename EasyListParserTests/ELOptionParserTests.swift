//
//  ELOptionParserTests.swift
//  Nope
//
//  Created by Nathanial Woolls on 10/2/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELOptionParserTests: XCTestCase {

    func testParseMatchCase() {
        // arrange
        let options = ["match-case"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertEqual(entry.trigger.urlFilterIsCaseSensitive, true)
    }
    
    func testParseDontMatchCase() {
        // arrange
        let options = ["~match-case"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertEqual(entry.trigger.urlFilterIsCaseSensitive, false)
    }
    
    func testParseDomains() {
        // arrange
        let options = ["domain=~google.com|example.org|example.com"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.ifDomain!.contains("example.org"))
        XCTAssertTrue(entry.trigger.ifDomain!.contains("example.com"))
        XCTAssertTrue(entry.trigger.unlessDomain!.contains("google.com"))
    }
    
    func testParseThirdParty() {
        // arrange
        let options = ["third-party"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.loadType!.contains("third-party"))
    }
    
    func testParseFirstParty() {
        // arrange
        let options = ["~third-party"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.loadType!.contains("first-party"))
    }
    
    func testParseScript() {
        // arrange
        let options = ["script"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.resourceType!.contains("script"))
    }
    
    func testParseImage() {
        // arrange
        let options = ["image"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.resourceType!.contains("image"))
    }
    
    func testParseStylesheet() {
        // arrange
        let options = ["stylesheet"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.resourceType!.contains("style-sheet"))
    }
    
    func testParseXMLHTTPRequest() {
        // arrange
        let options = ["xmlhttprequest"]
        let entry = ELBlockerEntry()
        
        // act
        do {
            try ELOptionParser.parse(options, destination: entry)
        } catch _ { }
        
        // assert
        XCTAssertTrue(entry.trigger.resourceType!.contains("raw"))
    }
    
}

