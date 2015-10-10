//
//  ELBlockerEntry+JSON.swift
//  EasyListParser
//
//  Created by Nathanial Woolls on 10/10/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

extension ELBlockerEntry {
    public func serialize(prettyPrinted: Bool = false) throws -> String?  {
        let json = try NSJSONSerialization.dataWithJSONObject(self.toCBEntry(), options: (prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()))
        return NSString(data: json, encoding: NSUTF8StringEncoding) as String?
    }
}

extension Array where Element: ELBlockerEntry {
    public func serialize(prettyPrinted: Bool = false) throws -> String?  {
        var subArray = [NSDictionary]()
        for item in self {
            subArray.append(item.toCBEntry())
        }
        
        let json = try NSJSONSerialization.dataWithJSONObject(subArray, options: (prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()))
        return NSString(data: json, encoding: NSUTF8StringEncoding) as String?
    }
}

extension ELBlockerEntry {
    public func toCBEntry() -> NSDictionary {
        let result = NSMutableDictionary()
        
        result.setValue(self.trigger.toCBEntry(), forKey: "trigger")
        
        result.setValue(self.action.toCBEntry(), forKey: "action")
        
        return result
    }
}

extension ELBlockerEntry.Trigger {
    func toCBEntry() -> NSDictionary {
        let result = NSMutableDictionary()
        
        if let triggerUrlFilter = self.urlFilter {
            result.setValue(triggerUrlFilter, forKey: "url-filter")
        }
        
        if let triggerUrlFilterIsCaseSensitive = self.urlFilterIsCaseSensitive {
            result.setValue(triggerUrlFilterIsCaseSensitive, forKey: "url-filter-is-case-sensitive")
        }
        
        if let triggerResourceType = self.resourceType {
            result.setValue(triggerResourceType, forKey: "resource-type")
        }
        
        if let triggerLoadType = self.loadType {
            result.setValue(triggerLoadType, forKey: "load-type")
        }
        
        if let triggerIfDomain = self.ifDomain {
            result.setValue(triggerIfDomain, forKey: "if-domain")
        }
        
        if let triggerUnlessDomain = self.unlessDomain {
            result.setValue(triggerUnlessDomain, forKey: "unless-domain")
        }
        
        return result
    }
}

extension ELBlockerEntry.Action {
    func toCBEntry() -> NSDictionary {
        let result = NSMutableDictionary()
        
        if let actionType = self.type {
            result.setValue(actionType.camelCaseToKebabCase(), forKey: "type")
        }
        
        if let actionSelector = self.selector {
            result.setValue(actionSelector, forKey: "selector")
        }
        
        return result
    }
}
