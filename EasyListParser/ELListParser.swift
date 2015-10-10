//
//  EasyListParser.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/22/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

// https://adblockplus.org/filters
// https://adblockplus.org/filter-cheatsheet

public class ELListParser {
            
    // parse the inputContent (EasyList text) creating a Safari Content Blocker
    // compatible representation
    public static func parse(inputContent: String, maxEntries: Int = 0, trustedDomains: [String] = []) -> [ELBlockerEntry] {
        var entries: [ELBlockerEntry] = []
        inputContent.enumerateLines { (line, stop) -> () in
            if maxEntries > 0 && entries.count >= maxEntries {
                return
            }
            
            do {
                let entry = try ELLineParser.parse(line)
                
                if (trustedDomains.count > 0)
                    // cannot have both ifDomain and unlessDomain
                    && (entry.trigger.ifDomain?.isEmpty ?? true) {
                        
                    entry.trigger.unlessDomain = entry.trigger.unlessDomain ?? []
                    entry.trigger.unlessDomain!.appendContentsOf(trustedDomains)
                }                
                
                entries.append(entry)
            } catch _ { }
        }
        return entries
    }
    
}
