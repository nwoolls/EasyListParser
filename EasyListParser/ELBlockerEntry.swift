//
//  BlockerEntry.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/24/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

public class ELBlockerEntry : Serializable {
    
    class Action : Serializable {
        
        enum Type : String {
            case Block
            case BlockCookies
            case CssDisplayNone
        }
        
        var type: String?
        var selector: String?
        
        override func formatValue(value: AnyObject?, forKey: String) -> AnyObject? {
            if forKey == "type" {
                if let typeValue = value as! String? {
                    return typeValue.camelCaseToKebabCase()
                }
            }
            return value
        }
    }
    
    class Trigger : Serializable {
        var urlFilter: String?
        var urlFilterIsCaseSensitive: Bool?
        var resourceType: [String]?
        var loadType: [String]?
        var ifDomain: [String]?
        var unlessDomain: [String]?
        
        override func formatKey(key: String) -> String {
            return key.camelCaseToKebabCase()
        }
    }
    
    var action: Action = Action()
    var trigger: Trigger = Trigger()
}