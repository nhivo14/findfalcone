//
//  DropdownTableViewCell.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit
import DropDown

class DropdownTableViewCell: UITableViewCell {

    @IBOutlet private weak var selectButton: UIButton!
    private let dropdown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didTapSelectButton(_ sender: UIButton) {
        dropdown.anchorView = sender
        dropdown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropdown.show()
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
              guard let _ = self else { return }
            sender.setTitle(item, for: .normal) }
    }
    
}

extension DropdownTableViewCell {
    func configureDropdown(data: [String]) {
        dropdown.dataSource = data
    }
}
