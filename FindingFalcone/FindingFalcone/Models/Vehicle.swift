//
//  Vehicle.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation

struct Vehicle {
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
}

struct Destination {
    var title: String? = nil
    var vehicleEntities: [VehicleViewEntity] = []
}


