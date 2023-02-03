//
//  SettingsController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit
import SnapKit

final class SettingsController: UIViewController {

    // MARK: - UI
    
    lazy var list: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup tableview
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Settings"
    }
    
    // MARK: - Setup tableview hierarchy
    
    private func setupHierarchy() {
        view.addSubview(list)
    }
    
    // MARK: - Setup tableview layout
    
    private func setupLayout() {
        list.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view)
        }
    }
}

