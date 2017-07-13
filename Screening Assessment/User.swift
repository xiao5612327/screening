//
//  Model.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/10/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import UIKit

class User: NSObject {
    var color: String?
    var code: String?
    var name: String?
    
    override init() {
        color = ""
        code = ""
        name = ""
    }
}
