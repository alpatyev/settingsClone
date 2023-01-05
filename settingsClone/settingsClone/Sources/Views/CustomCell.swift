//
//  CustomCell.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/4/23.
//

import UIKit

protocol CustomCell: UITableViewCell {
    static var identifier: String { get set }
    var internalData: Cell? { get set }
    
    func updateSubviews()
    func updateSetingsModel()
}

