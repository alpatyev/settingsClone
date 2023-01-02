//
//  SettingsModel.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation

// MARK: - Data model

struct Cell: Codable {
    var image: String
    var text: String
    var rightView: String?
}

struct Section: Codable {
    var name: String
    var cells: [Cell]
}

struct Settings: Codable {
    var sectionData = [Section]()
}

// MARK: - Model for first screen settings

struct SettingsModel {
    
    static var resourceName = "settings"
    static var list = [Section]()
    
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
            
            SettingsModel.list.forEach { section in
                print("SECTION: \(section.name)")
                section.cells.forEach { cell in
                    print("-CELL WITH: \(cell.image).jpg + [\(cell.text)] + action @\(cell.rightView ?? "nextVC")")
                }
            }
        }
    }
}

