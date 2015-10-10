//
//  String+Casing.swift
//  Nope
//
//  Created by Nathanial Woolls on 9/24/15.
//  Copyright © 2015 Nathanial Woolls. All rights reserved.
//

import Foundation

extension String {
    func camelCaseToKebabCase() -> String {
        return self.stringByReplacingOccurrencesOfString("([a-z])([A-Z])", withString: "$1-$2", options: .RegularExpressionSearch).lowercaseString
    }
}
