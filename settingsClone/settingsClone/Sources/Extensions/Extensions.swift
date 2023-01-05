//
//  Extensions.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation
import UIKit

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Setup sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingsModel.list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsModel.list[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) && (indexPath.row == 0) {
            return 80
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        22
    }
    
    // MARK: - Setup cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = list.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier,
                                                  for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: SettingsModel.returnCellFrom(indexPath.section, indexPath.row))
        return cell
    }
    
    // MARK: - Recognize selected cell action
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.deselectRow(at: indexPath, animated: true)
    }
}

extension UITableViewCell {
    
    // MARK: - Index path inside cell class
    
    var indexPath: IndexPath? {
        guard let table = superview as? UITableView else {
            return nil
        }
        return table.indexPath(for: self)
    }
}

