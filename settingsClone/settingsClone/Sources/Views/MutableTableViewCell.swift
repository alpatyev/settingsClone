//
//  MutableTableViewCell.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/2/23.
//

import UIKit
import SnapKit

class MutableTableViewCell: UITableViewCell {
    
    static var identifier = "systemSettings"
    
    // MARK: - UI
    
    private var model: Cell?
    
    // MARK: - Setups
    
    public func configure(with cell: Cell?) {
        model = cell
    }
}
