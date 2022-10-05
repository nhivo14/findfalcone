//
//  DataRequest.swift
//  FindingFalcone
//
//  Created by grandM on 10/5/22.
//

import Foundation

struct DataRequest: Codable {
    var token: String
    var planet_names: [String]
    var vehicle_name: [String]
}
