//
//  ViewController.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var findFalconeButton: UIButton!
    @IBOutlet private weak var selectionsTableview: UITableView!
    
    var model = SelectionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.initModel()
        setupUI()
        
    }

    // Actions
    @IBAction func didTapFindFalconeButton(_ sender: Any) {
        print("hhii")
    }
    
}

extension ViewController {
    func setupUI() {
        title = "Finding Falcone!"
        selectionsTableview.delegate = self
        selectionsTableview.dataSource = self
        selectionsTableview.register(UINib(nibName: "DropdownTableViewCell", bundle: nil), forCellReuseIdentifier: "dropdownCell")
        selectionsTableview.register(UINib(nibName: "RadioTableViewCell", bundle: nil), forCellReuseIdentifier: "radioCell")
        
    }
}

// UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.didSelectVehicle(indexPath: indexPath)
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}

// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.destinations[section].vehicleEntities.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "dropdownCell", for: indexPath) as? DropdownTableViewCell else { return UITableViewCell() }

            cell.delegate = self
            cell.configureDropdown(title: model.destinations[indexPath.section].title, section: indexPath.section)
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

extension ViewController: DropdownCellDelegate {
    func getDropdownList() -> [String] {
        model.getListDropdown()
    }
    
    func getInfoSection(section: Int, title: String) {
        model.updateInfoSelection(section: section, title: title)
        selectionsTableview.reloadData()
    }
    
}
