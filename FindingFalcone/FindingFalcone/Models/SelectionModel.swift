//
//  SelectionModel.swift
//  FindingFalcone
//
//  Created by NhiVHY on 04/10/2022.
//

import Foundation

class SelectionModel: NSObject {
    
    private var vehicles: [Vehicle] = []
    private var planets: [Planet] = []
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
        let distance = selectedPlanet.distance
        destinations[section].vehicleEntities = vehicles.map { VehicleViewEntity(name: $0.name,
                                                                                 isSelected: false,
                                                                                 isEnable: $0.max_distance >= distance && ($0.total_no - countOccurrences(vehicleName: $0.name) > 0),
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
    
    func getListPlanetRequest() -> [String] {
        return destinations.compactMap { $0.planet }
    }
    
    func getListVehiclesRequest() -> [String] {
        let vehicleEntities = destinations.map { $0.vehicleEntities.filter { $0.isSelected == true }}
        let vehicles = vehicleEntities.flatMap { $0.map { $0.name} }
        return vehicles
    }
    
    func countTimeTaken() -> Int {
        var time = 0
        let planets = getListPlanetRequest()
        let vehicles = getListVehiclesRequest()
        for i in 0...3 {
            let distance = self.planets.first { $0.name == planets[i]}?.distance ?? 0
            let speed = self.vehicles.first { $0.name == vehicles[i]}?.speed ?? 1
            time = time + Int(distance/speed)
        }
        return time
    }
    
    func countOccurrences(vehicleName: String) -> Int {
        var count = 0
        destinations.forEach {
            $0.vehicleEntities.forEach {
                if $0.name == vehicleName && $0.isSelected {
                    count += 1
                }
            }
        }
        return count
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
