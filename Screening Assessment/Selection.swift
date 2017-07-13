//
//  Selection.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import Foundation

struct Section {
    var name: String!
    var color: String!
    var code: String!
    var expanded: Bool!
    
    var footer: String!
    
    init(name: String, color: String, code: String, expanded: Bool) {
        self.name = name
        self.color = color
        self.expanded = expanded
        self.code = code
        self.footer = "Color: " + color + "         " + "Code: " + code
    }
}

