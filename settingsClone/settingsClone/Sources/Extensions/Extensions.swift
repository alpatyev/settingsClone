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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        22
    }
    
    // MARK: - Setup cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = list.dequeueReusableCell(withIdentifier: MutableTableViewCell.identifier,
                                                  for: indexPath) as? MutableTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: SettingsModel.selectCellFrom(indexPath.section, indexPath.row))
        return cell
    }
    
    // MARK: - Recognize selected cell action
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.deselectRow(at: indexPath, animated: true)
    }
}

