//
//  SettingsDataModel.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 2/3/23.
//

import Foundation

final class SettinsDataModel {
    
    // MARK: - Private properties
    
    private let resourceName = "settings"
    private var list = [Section]()
    
    // MARK: - Initial
    
    init() {
        setupData()
    }
    
    // MARK: - Setups
    
    private func fetch() -> Settings? {
        guard let settingsPath = Bundle.main.path(forResource: resourceName, ofType: "json") else {
            return nil
        }
        
        let url = URL(fileURLWithPath: settingsPath)
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(Settings.self, from: data)
        } catch {
            return nil
        }
    }
    
    private func setupData() {
        if let result = fetch() {
            list = result.sectionData
        }
    }
    
    // MARK: - Get models for main scene sections
    
    public func getSettingsList() -> [Section] {
        list
    }
    
    // MARK: - Update internal data
    
    public func updateCellSwitcher(from path: IndexPath?, switchState: Bool?) {
        guard let indexPath = path else {
            return
        }
        guard indexPath.section < list.count else {
            return
        }
        guard indexPath.row < list[indexPath.section].cells.count else {
            return
        }
        list[indexPath.section].cells[indexPath.row].switcher = switchState
    }
    
    public func returnCellFrom(_ sectionIndex: Int, _ rowIndex: Int) -> Cell? {
        guard sectionIndex < list.count else {
            return nil
        }
        guard rowIndex < list[sectionIndex].cells.count else {
            return nil
        }
        return list[sectionIndex].cells[rowIndex]
    }
}
