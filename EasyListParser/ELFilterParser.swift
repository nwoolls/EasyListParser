//
//  ELFilterParser.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/29/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

// https://adblockplus.org/filters
// https://adblockplus.org/filter-cheatsheet

// transform an EasyList domain / URL filter into a real RegEx
class ELFilterParser {
    static func parse(filter: String) -> String {
        var result = filter
        if result.isEmpty {
            result = ".*"
        } else {
            
            // escape special regex characters
            result = result
                .stringByReplacingOccurrencesOfString(".", withString: "\\.")
                .stringByReplacingOccurrencesOfString("?", withString: "\\?")
                .stringByReplacingOccurrencesOfString("+", withString: "\\+")
            
            // * is to be assumed, but may already be present in the domain
            // or the domain may include pipes to override the liberal use of *
            if result.characters.first != "*" && result.characters.first != "|" {
                result = "*" + result
            }
            if result.characters.last != "*" && result.characters.last != "|" && result.characters.last != "^" {
                result += "*"
            }
            
            // * matches any series of characters
            result = result.stringByReplacingOccurrencesOfString("*", withString: ".*")
            
            let separator = "[\\?\\/\\-_:]"
            
            // ^ marks a separator character like ? or / has to follow.
            // must do in 2 steps as ContentBlocker RegEx doesn't support (this|format)
            if result.characters.last == "^" {
                result = String(result.characters.dropLast())
                result += "(" + separator + ".*)?$"
            }
            
            result = result.stringByReplacingOccurrencesOfString("^", withString: separator)
            
            // || marks the begining of a domain
            if result.characters.startsWith("||".characters) {
                result = String(result.characters.dropFirst(2))
                result = "^(?:[^:/?#]+:)?(?://(?:[^/?#]*\\.)?)?" + result
            }
            
            // | marks the beginning of a domain
            if result.characters.first == "|" {
                result = String(result.characters.dropFirst())
                result = "^" + result
            }
            
            // | marks the end of a domain
            if result.characters.last == "|" {
                result = String(result.characters.dropLast())
                result += "$"
            }
            
            // escape remaining special regex characters incl. pipes
            result = result.stringByReplacingOccurrencesOfString("|", withString: "\\|")
            
            // unescape the over-escaped - EasyList has some occasional escaping
            result = result.stringByReplacingOccurrencesOfString("\\\\", withString: "\\")
        }
        return result
    }

}