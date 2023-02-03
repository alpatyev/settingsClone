//
//  SettingsController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation
import SnapKit
import UIKit

final class SettingsListController: UIViewController {
    
    var model: SettinsDataModel?
    
    private var settingsListView: SettingsListView? {
        guard isViewLoaded else { return nil }
        return view as? SettingsListView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Settings"
        
        view = SettingsListView()
        model = SettinsDataModel()
        
        configureView()
    }
    
    // MARK: - Setups
        
    private func configureView() {
        guard let models = model?.getSettingsList() else { return }
        settingsListView?.configureView(with: models, controller: self)
    }
    
    // MARK: - User actions
    
    public func switchChanged(at indexPath: IndexPath?, with cell: Cell) {
        model?.updateCellSwitcher(from: indexPath, switchState: cell.switcher)
        
        if let path = indexPath {
            settingsListView?.configureList(at: path, with: cell)
        }
    }
    
    public func selectedCell(at indexPath: IndexPath) {
        if let cell = model?.returnCellFrom(indexPath.section, indexPath.row) {
            if (cell.switcher == nil) {
                let detailViewController = DetailController()
                detailViewController.setupTitle(cell.title)
                detailViewController.setupImage(from: cell.image)
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}
