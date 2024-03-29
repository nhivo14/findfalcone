//
//  SelectionModel.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation

class SelectionModel {
    private var listPlanets: [Planet] = [Planet(name: "Donlon", distance: 100),
                                 Planet(name: "Enchai", distance: 200),
                                 Planet(name: "Jebing", distance: 300),
                                 Planet(name: "Sapir", distance: 400),
                                 Planet(name: "Lerbin", distance: 500),
                                 Planet(name: "Pingasor", distance: 600)]
    
    private var listVehicles: [Vehicle] = [Vehicle(name: "Space pod", total_no: 2, max_distance: 200,
                                           speed: 2),
                                   Vehicle(name: "Space rocket", total_no: 1, max_distance: 300, speed: 4),
                                   Vehicle(name: "Space shuttle", total_no: 1, max_distance: 400, speed: 5),
                                   Vehicle(name: "Space ship", total_no: 2, max_distance: 600, speed: 10)]
    
    var destinations: [Destination] = []

    func initModel() {
        destinations = [Destination(),
                        Destination(),
                        Destination(),
                        Destination()]
    }
    
    func getListDropdown() -> [String] {
        let selectedPlanet = destinations.compactMap { $0.title }
        return listPlanets.filter { !selectedPlanet.contains($0.name) }.map { $0.name }
    }
    
    func updateInfoSelection(section: Int, title: String) {
        destinations[section].title = title
        destinations[section].vehicleEntities = listVehicles.map { VehicleViewEntity(name: $0.name, isSelected: false, isEnable: false, total_no: $0.total_no)}
    }
    
    func didSelectVehicle(indexPath: IndexPath) {
        let isSelected = destinations[indexPath.section].vehicleEntities[indexPath.row - 1].isSelected
        if !isSelected {
            destinations[indexPath.section].vehicleEntities.indices.forEach {
                if $0 == indexPath.row - 1 {
                    self.destinations[indexPath.section].vehicleEntities[$0].isSelected = true
                } else {
                    self.destinations[indexPath.section].vehicleEntities[$0].isSelected = false
                }
            }
        }
    }
}
