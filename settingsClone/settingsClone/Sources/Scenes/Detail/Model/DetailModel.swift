//
//  DetailModel.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 2/3/23.
//

struct DetalModel {
    let image: String
    let title: String
    var isFlipping: Bool = false {
        didSet {
            print("'\(title)' icon \(isFlipping ? "is" : "is not") flipping now" )
        }
    }
}
