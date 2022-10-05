//
//  Token.swift
//  FindingFalcone
//
//  Created by  on 05/10/2022.
//

import Foundation

var TOKEN = ""

struct Token: Decodable {
    var token: String
}

struct FinalResult: Codable {
    var planet_name: String?
    var status: String?
    var error: String?
}
