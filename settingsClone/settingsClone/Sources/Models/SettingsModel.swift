//
//  SettingsModel.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation

// MARK: - Data model

struct Cell: Codable {
    let image: String
    let title: String
    
    var subtitle: String? = nil
    var badges: Int? = nil
    var switcher: Bool? = nil
}

struct Section: Codable {
    let name: String
    var cells: [Cell]
}

struct Settings: Codable {
    var sectionData = [Section]()
}

// MARK: - Model for first screen settings

struct SettingsModel {
    
    static var resourceName = "settings"
    static var list = [Section]()
    
    static func selectCellFrom(_ sectionIndex: Int, _ rowIndex: Int) -> Cell? {
        guard sectionIndex < SettingsModel.list.count else {
            return nil
        }
        guard rowIndex < SettingsModel.list[sectionIndex].cells.count else {
            return nil
        }
        return SettingsModel.list[sectionIndex].cells[rowIndex]
    }
    
    static func fetch() -> Settings? {
        guard let settingsPath = Bundle.main.path(forResource: SettingsModel.resourceName, ofType: "json") else {
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
    
    static func updateData() {
        if let result = SettingsModel.fetch() {
            SettingsModel.list = result.sectionData
        }
    }
}

