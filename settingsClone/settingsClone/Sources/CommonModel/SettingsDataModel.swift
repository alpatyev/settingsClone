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
    
    public func updateCellSwitcher(from indexPath: IndexPath?, switchState: Bool?) {
        guard let path = indexPath else { return }
        list[path.section].cells[path.row].switcher = switchState
    }
    
    public func returnCell(from indexPath: IndexPath?) -> Cell? {
        guard let path = indexPath else { return nil }
        guard path.section < list.count else { return nil }
        guard path.row < list[path.section].cells.count else { return nil }
        
        return list[path.section].cells[path.row]
    }
}
