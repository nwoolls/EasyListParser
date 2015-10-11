//
//  ELEndToEndTests.swift
//  EasyListParser
//
//  Created by Nathanial Woolls on 10/11/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import XCTest
@testable import EasyListParser

class ELEndToEndTests: XCTestCase {

    func testEndToEnd() {
        let easyListURI = "https://easylist-downloads.adblockplus.org/easyprivacy_nointernational.txt"
        var blockerEntries: [ELBlockerEntry] = []
        var blockerJson: String?
        let maxEntries = 50000 // max allowed by Safari
        let trustedDomains = ["www.reddit.com"]
        
        if let easyListURL = NSURL(string: easyListURI) {
            do {
                let easyListContent = try String(contentsOfURL: easyListURL);
                blockerEntries = ELListParser.parse(easyListContent, maxEntries: maxEntries, trustedDomains: trustedDomains)
                blockerJson = try blockerEntries.serialize()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        XCTAssertNotNil(blockerJson)
        XCTAssertTrue(blockerEntries.count > 0)
    }
}