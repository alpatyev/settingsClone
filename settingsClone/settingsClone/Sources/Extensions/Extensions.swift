//
//  Extensions.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation
import UIKit

// MARK: - Table view

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}

