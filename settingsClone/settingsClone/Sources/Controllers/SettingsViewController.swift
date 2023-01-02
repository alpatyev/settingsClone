//
//  SettingsViewController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/1/23.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    // MARK: - UI
    
    lazy var list: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup view
    
    private func setupView() {
        view.backgroundColor = .darkGray
    }
    
    // MARK: - Setup hierarchy
    
    private func setupHierarchy() {
        view.addSubview(list)
    }
    
    // MARK: - Setup layout
    
    private func setupLayout() {
        list.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(view)
        }
    }
    
    // MARK: - Actions

}

