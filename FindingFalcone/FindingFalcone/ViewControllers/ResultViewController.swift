//
//  ResultViewController.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var timeTakenLabel: UILabel!
    @IBOutlet weak var planetLabel: UILabel!
    
    var result: FinalResult?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func didTapStartAgain(_ sender: Any) {
    }
}

extension ResultViewController {
    func setupUI() {
        title = "Finding Falcone!"
        guard let result = result else { return }
        statusLabel.text = result.status?.uppercased() ?? ""
        errorLabel.text = result.error ?? ""
        planetLabel.text = result.planet_name ?? ""
        errorLabel.isHidden = result.error == nil ? true : false
        if result.status != nil {
            statusLabel.isHidden = false
            if result.planet_name != nil {
                planetLabel.isHidden = false
                timeTakenLabel.isHidden = false
                planetLabel.isHidden = false
            } else {
                planetLabel.isHidden = true
                timeTakenLabel.isHidden = true
                planetLabel.isHidden = true
            }
        }
    }
}
