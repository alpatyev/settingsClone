//
//  SettingsView.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/24/23.
//

import UIKit

class SettingsView: UIView {
    
    
        
    // MARK: - UI
    
    lazy var list: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self,
                           forCellReuseIdentifier: SettingsCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Setup tableview
    
    private func setupView() {
        backgroundColor = .white
    }
    
    // MARK: - Setup tableview hierarchy
    
    private func setupHierarchy() {
        addSubview(list)
    }
    
    // MARK: - Setup tableview layout
    
    private func setupLayout() {
        list.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
