//
//  Selection.swift
//  Screening Assessment
//
//  Created by Xiaoping Weng on 7/12/17.
//  Copyright © 2017 Xiaoping Weng. All rights reserved.
//

import Foundation

struct Section {
    var genre: String!
    var movies: [String]!
    var expanded: Bool!
    
    init(genre: String, movies: [String], expanded: Bool) {
        self.genre = genre
        self.movies = movies
        self.expanded = expanded
    }
}

