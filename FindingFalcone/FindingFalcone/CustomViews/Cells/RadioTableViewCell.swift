//
//  RadioTableViewCell.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit

class RadioTableViewCell: UITableViewCell {

    @IBOutlet private weak var radioImageView: UIImageView!
    @IBOutlet private weak var optionLabel: UILabel!
    
    private let checkedImage = UIImage(systemName: "checkmark.circle.fill")
    private let uncheckedImage = UIImage(systemName: "circle")
    var section: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension RadioTableViewCell {
    func configureSelectedItem(vehicleEnity: VehicleViewEntity) {
        let image = vehicleEnity.isSelected ? checkedImage : uncheckedImage
        radioImageView.image = image
        optionLabel.text = vehicleEnity.name
        self.isUserInteractionEnabled = vehicleEnity.isEnable
        optionLabel.alpha = vehicleEnity.isEnable ? 1 : 0.5
    }
}
