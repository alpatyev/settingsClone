//
//  SettingsViewController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private var settingsModel: SettingsModel? 
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    // MARK: - Setups
    
    private func setupController() {
        view = SettingsView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    // MARK: - Actions
    
    public func cellTapped(path: IndexPath) {
        if let cell = SettingsModel.returnCellFrom(path.section, path.row) {
            if (cell.switcher == nil) {
                let detailViewController = DetailViewController()
                detailViewController.configure(with: cell)
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}

