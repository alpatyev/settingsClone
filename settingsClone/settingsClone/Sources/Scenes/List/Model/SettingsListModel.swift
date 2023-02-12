//
//  SettingsModel.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import Foundation

// MARK: - Data model entities

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
