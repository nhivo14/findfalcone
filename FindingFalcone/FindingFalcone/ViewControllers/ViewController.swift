//
//  ViewController.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit

struct RadioStruct {
    let name: String
    var isSelected: Bool
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var findFalconeButton: UIButton!
    @IBOutlet private weak var selectionsTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        selectionsTableview.register(UINib(nibName: "RadioTableViewCell", bundle: nil), forCellReuseIdentifier: "radioCell")
        
    }
}

// UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "radioCell", for: indexPath) as? RadioTableViewCell else { return UITableViewCell() }
//        let data = ["Tomato soup", "Mini burgers", "Onion rings", "Baked potato", "Salad"]
//        cell.configureDropdown(data: data)
       
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
