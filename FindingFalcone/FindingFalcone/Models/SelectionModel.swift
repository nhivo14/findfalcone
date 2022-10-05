//
//  SelectionModel.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation

class SelectionModel: NSObject {
//    private var listPlanets: [Planet] = [Planet(name: "Donlon", distance: 100),
//                                 Planet(name: "Enchai", distance: 200),
//                                 Planet(name: "Jebing", distance: 300),
//                                 Planet(name: "Sapir", distance: 400),
//                                 Planet(name: "Lerbin", distance: 500),
//                                 Planet(name: "Pingasor", distance: 600)]
//    
//    private var listVehicles: [Vehicle] = [Vehicle(name: "Space pod", total_no: 2, max_distance: 200,
//                                           speed: 2),
//                                   Vehicle(name: "Space rocket", total_no: 1, max_distance: 300, speed: 4),
//                                   Vehicle(name: "Space shuttle", total_no: 1, max_distance: 400, speed: 5),
//                                   Vehicle(name: "Space ship", total_no: 2, max_distance: 600, speed: 10)]
    private var vehicles: [Vehicle] = []
    private var planets: [Planet] = []
    private var selectedPlanets: [String] = []
    private var selctedVehicles: [String] = []
    private var vehicleParams: [VehicleViewEntity] = []
    private var token: String = ""
    var fetchDataSuccess: (FinalResult) -> Void = { _ in }
    var destinations: [Destination] = []
    let network = NetworkService()

    func initModel() {
        destinations = [Destination(),
                        Destination(),
                        Destination(),
                        Destination()]
        getListVehicles()
        getListPlanets()
    }
    
    func getListDropdown() -> [String] {
        let selectedPlanet = destinations.compactMap { $0.planet }
        return planets.filter { !selectedPlanet.contains($0.name) }.map { $0.name }
    }
    
    func updateInfoSelection(section: Int, planet: String) {
        destinations[section].planet = planet
        guard let selectedPlanet = planets.first(where: {$0.name == planet}) else { return }
        if !selectedPlanets.contains(planet) {
            selectedPlanets.append(planet)
        }
        let distance = selectedPlanet.distance
        destinations[section].vehicleEntities = vehicles.map { VehicleViewEntity(name: $0.name,
                                                                                 isSelected: false,
                                                                                 isEnable: $0.max_distance >= distance,
                                                                                 total_no: $0.total_no,
                                                                                 max_distance: $0.max_distance,
                                                                                 speed: $0.speed)}
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

// MARK: - Call API
extension SelectionModel {
    func findFalcone(params: DataRequest) {
        network.findFalcone(body: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let finalResult):
                guard let finalResult = finalResult else { return }
                self.fetchDataSuccess(finalResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getListVehicles() {
        network.getListVehicles() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let vehicles):
                guard let vehicles = vehicles else { return }
                self.vehicles = vehicles
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getListPlanets() {
        network.getListPlanets() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case.success(let planets):
                guard let planets = planets else { return }
                self.planets = planets
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
