//
//  RegularTableViewCell.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit
import SnapKit

class RegularTableViewCell: UITableViewCell {
   
    static let identifier = "regular"
    
    // MARK: - UI
    
    internal lazy var leftContainer: UIView  = {
        let container = UIView()
        return container
    }()
    
    private lazy var centerContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    private lazy var rightContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .magenta
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // all ui must be nil
    }
    
    // MARK: - Sync to the model
    
    // MARK: - Actions
    
}

