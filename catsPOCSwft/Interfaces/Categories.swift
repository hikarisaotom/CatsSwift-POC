//
//  Categories.swift
//  catsPOCSwft
//
//  Created by Claudia Cortes on 6/16/22.
//

import Foundation


typealias Categories = [Category]
struct Category:Decodable {
    let id: Int
    let name: String
}


