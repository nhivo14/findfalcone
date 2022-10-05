//
//  Token.swift
//  FindingFalcone
//
//  Created by  on 05/10/2022.
//

import Foundation
var TOKEN = ""
struct Token: Decodable {
    let token: String
}

struct FalconeResponse: Decodable {
    let planet_name: String?
    let status: String?
    let error: String?
}
