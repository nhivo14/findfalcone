//
//  DropdownTableViewCell.swift
//  FindingFalcone
//
//  Created by grandM on 10/3/22.
//

import UIKit
import DropDown

protocol DropdownCellDelegate: AnyObject {
    func getInfoSection(section: Int, title: String)
    func getDropdownList() -> [String]
}

class DropdownTableViewCell: UITableViewCell {

    @IBOutlet private weak var selectButton: UIButton!
    
    private let dropdown = DropDown()
    var section: Int = -1
    weak var delegate: DropdownCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didTapSelectButton(_ sender: UIButton) {
        dropdown.dataSource = delegate?.getDropdownList() ?? []
        dropdown.anchorView = sender
        dropdown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropdown.show()
        dropdown.selectionAction = { [weak self] (index: Int, item: String) in
              guard let self = self else { return }
            sender.setTitle(item, for: .normal)
            self.delegate?.getInfoSection(section: self.section, title: item)
        }
    }
    
}

extension DropdownTableViewCell {
    func configureDropdown(title: String?, section: Int) {
        selectButton.setTitle(title ?? "Select", for: .normal)
        self.section = section
    }
}
