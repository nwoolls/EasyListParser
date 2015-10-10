//
//  ELLineParser.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

// https://adblockplus.org/filters
// https://adblockplus.org/filter-cheatsheet

class ELLineParser {
    
    static func parse(line: String) throws -> ELBlockerEntry {
        
        var error = "Unknown error"
        
        if let char = line.characters.first {
            switch char {
            case "[", "!", "@" :
                error = "Unsupported prefix: \(char)"
                break
            default:
                
                var domainFilter: String = ""
                var cssSelector: String = ""
                var filterOptions: String = ""
                
                if line.containsString("##") {
                    let cssParts = line.componentsSeparatedByString("##")
                    domainFilter = cssParts[0]
                    cssSelector = cssParts[1]
                } else if line.containsString("$") {
                    var optionParts = line.componentsSeparatedByString("$")
                    
                    //this may be more than 2 parts, e.g. 3, and the first 2 are the domain, concat
                    filterOptions = optionParts.last!
                    optionParts.removeLast()
                    domainFilter = optionParts.joinWithSeparator("");
                    
                } else {
                    domainFilter = line
                }
                
                if !domainFilter.canBeConvertedToEncoding(NSASCIIStringEncoding) {
                    // limitation of RegEx in WebKit Content Blocker
                    error = "Filter contains non-ASCII"
                    break
                }                
            
                if domainFilter.containsString("{") {
                    // limitation of RegEx in WebKit Content Blocker
                    error = "Filter contains {"
                    break
                }

                let filterOptionParts: [String]
                if !filterOptions.isEmpty {
                    filterOptionParts = filterOptions.componentsSeparatedByString(",")
                    
                } else {
                    filterOptionParts = []
                }

                let entry = ELBlockerEntry()
                entry.trigger.urlFilter = ELFilterParser.parse(domainFilter)
                
                if cssSelector.isEmpty {
                    entry.action.type = ELBlockerEntry.Action.Type.Block.rawValue
                } else {
                    entry.action.type = ELBlockerEntry.Action.Type.CssDisplayNone.rawValue
                    entry.action.selector = cssSelector
                }
                
                try ELOptionParser.parse(filterOptionParts, destination: entry)
                
                return entry
            }
            
        }
                
        throw ELParserError.InvalidInput(error, line)
    }
}