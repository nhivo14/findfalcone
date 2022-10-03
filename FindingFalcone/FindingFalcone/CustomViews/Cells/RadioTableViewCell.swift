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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension RadioTableViewCell {
    func configureSelectedItem(_ selected: Bool) {
        setSelected(selected, animated: false)
        let image = selected ? checkedImage : uncheckedImage
        radioImageView.image = image
    }
}
