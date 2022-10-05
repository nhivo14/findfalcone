//
//  Vehicle.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation

struct Vehicle: Codable {
    var name: String
    var total_no: Int
    var max_distance: Int
    var speed: Int
}

struct VehicleViewEntity {
    var name: String
    var isSelected: Bool
    var isEnable: Bool
    var total_no: Int
    var max_distance: Int
    var speed: Int
}

struct Destination {
    var planet: String? = nil
    var vehicleEntities: [VehicleViewEntity] = []
}


