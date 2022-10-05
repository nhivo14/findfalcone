//
//  ViewController.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var findFalconeButton: UIButton!
    @IBOutlet private weak var selectionsTableview: UITableView!
    
    // MARK: - Properties
    var model = SelectionModel()
    
    /// hard code for testing
    var planets: [String] = ["Donlon", "Enchai", "Jebing", "Sapir"]
    var vehicles: [String] = ["Space pod", "Space rocket", "Space shuttle", "Space ship"]

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        model.initModel()
        setupUI()
        model.fetchDataSuccess = { result in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultViewController.result = result
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
    }

    // MARK: - Actions
    @IBAction func didTapFindFalconeButton(_ sender: Any) {
        model.findFalcone(params: DataRequest(token: TOKEN, planet_names: planets, vehicle_name: vehicles))
    }
    
}

// MARK: - Helpers
extension ViewController {
    func setupUI() {
        title = "Finding Falcone!"
        selectionsTableview.delegate = self
        selectionsTableview.dataSource = self
        selectionsTableview.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "dropdownCell")
        selectionsTableview.register(UINib(nibName: "RadioTableViewCell", bundle: nil), forCellReuseIdentifier: "radioCell")
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.didSelectVehicle(indexPath: indexPath)
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
//        if !vehicles.contains(where:{ $0 == model.vehicles[indexPath.row - 1].name}) && vehicles.count < 1 {
//            vehicles.append(model.vehicles[indexPath.row - 1].name)
//            print(vehicles)
//        }
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.destinations[section].vehicleEntities.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dropdownCell", for: indexPath) as? DropdownTableViewCell else { return UITableViewCell() }

            cell.delegate = self
            cell.configureDropdown(title: model.destinations[indexPath.section].planet, section: indexPath.section)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell", for: indexPath) as? RadioTableViewCell else { return UITableViewCell() }
            cell.configureSelectedItem(vehicleEnity: model.destinations[indexPath.section].vehicleEntities[indexPath.row - 1])
            cell.selectionStyle = .none
            return cell
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return model.destinations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Destination " + "\(section + 1)"
    }
    
}

// MARK: - DropdownCellDelegate
extension ViewController: DropdownCellDelegate {
    func getDropdownList() -> [String] {
        model.getListDropdown()
    }
    
    func getInfoSection(section: Int, planet: String) {
        model.updateInfoSelection(section: section, planet: planet)
        selectionsTableview.reloadData()
    }
    
}
