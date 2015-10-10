//
//  ELOptionParser.swift
//  Nope
//
//  Created by Nathanial Woolls on 10/2/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

class ELOptionParser {
    
    enum FilterOption: String {
        case MatchCase = "match-case"
        case Domain = "domain"
        case ThirdParty = "third-party"
        case Script = "script"
        case Image = "image"
        case Stylesheet = "stylesheet"
        case XMLHTTPRequest = "xmlhttprequest"
    }
    
    static func parse(options: [String], destination: ELBlockerEntry) throws {
        for filterOption in options {
            
            if filterOption == FilterOption.MatchCase.rawValue {
                destination.trigger.urlFilterIsCaseSensitive = true
            } else if filterOption == "~" + FilterOption.MatchCase.rawValue {
                destination.trigger.urlFilterIsCaseSensitive = false
            } else if filterOption.hasPrefix(FilterOption.Domain.rawValue + "=") {
                let domainParts = filterOption.componentsSeparatedByString("=")
                let domainList = domainParts[1]
                let domains = domainList.componentsSeparatedByString("|")
                
                for var domain in domains {
                    if  // limitation of RegEx in WebKit Content Blocker
                        domain.canBeConvertedToEncoding(NSASCIIStringEncoding) {
                            
                            if domain.hasPrefix("~") {
                                if destination.trigger.unlessDomain == nil {
                                    destination.trigger.unlessDomain = []
                                }
                                domain.removeAtIndex(domain.startIndex)
                                destination.trigger.unlessDomain!.append(domain)
                            } else {
                                if destination.trigger.ifDomain == nil {
                                    destination.trigger.ifDomain = []
                                }
                                destination.trigger.ifDomain!.append(domain)
                            }
                    } else {
                        // limitation of RegEx in WebKit Content Blocker
                        throw ELParserError.InvalidInput("Options contain non-ASCII", options.description)
                    }
                }
            } else if filterOption == FilterOption.ThirdParty.rawValue {
                destination.trigger.loadType = ["third-party"]
            } else if filterOption == "~" + FilterOption.ThirdParty.rawValue {
                destination.trigger.loadType = ["first-party"]
            } else if filterOption == FilterOption.Script.rawValue {
                if destination.trigger.resourceType == nil {
                    destination.trigger.resourceType = []
                }
                destination.trigger.resourceType!.append("script")
            } else if filterOption == FilterOption.Image.rawValue {
                if destination.trigger.resourceType == nil {
                    destination.trigger.resourceType = []
                }
                destination.trigger.resourceType!.append("image")
            } else if filterOption == FilterOption.Stylesheet.rawValue {
                if destination.trigger.resourceType == nil {
                    destination.trigger.resourceType = []
                }
                destination.trigger.resourceType!.append("style-sheet")
            } else if filterOption == FilterOption.XMLHTTPRequest.rawValue {
                if destination.trigger.resourceType == nil {
                    destination.trigger.resourceType = []
                }
                destination.trigger.resourceType!.append("raw")
            } else {
                // we don't know enough about the entry's filter options
                throw ELParserError.InvalidInput("Unsupported option(s)", options.description)
            }
            
        }
    }
}