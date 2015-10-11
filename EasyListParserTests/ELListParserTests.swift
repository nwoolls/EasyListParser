//
//  ELListParserTests.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELListParserTests: XCTestCase {

    func testParseInput() {
        // arrange
        let input = "?AdUrl=\n" +
            "?bannerid=*&punder=\n" +
            "?iiadext=$popup\n" +
            "?zoneid=*_bannerid=\n" +
            "_popunder+\n" +
            "!------------------------General element hiding rules-------------------------!\n" +
            "! *** easylist:easylist/easylist_general_hide.txt ***\n" +
            "###A9AdsMiddleBoxTop\n" +
            "###A9AdsOutOfStockWidgetTop\n" +
            "###A9AdsServicesWidgetTop\n" +
            "###AD-300x250";
        let domains = ["google.com", "example.org"]
        let maxEntries = 5
        
        // act
        let actual = ELListParser.parse(input, maxEntries: maxEntries, trustedDomains: domains)
        
        // assert
        XCTAssertEqual(maxEntries, actual.count)
        XCTAssertEqual(domains.count, actual.first?.trigger.unlessDomain?.count)
    }
    
}
