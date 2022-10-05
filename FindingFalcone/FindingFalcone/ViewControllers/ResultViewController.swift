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
    }
}
