//
//  SettingsListView.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 2/2/23.
//

import UIKit

class SettingsListView: UIView {
    
    // MARK: - Configuration

    func configureView(with models: [Section], controller: SettingsListController) {
        self.models = models
        self.controller = controller
        list.reloadData()
    }
    
    func configureList(at indexPath: IndexPath?, with model: Cell) {
        guard let path = indexPath else { return }
        models[path.section].cells[path.row] = model
        list.reloadData()
    }

    // MARK: - Private properties
    
    private var controller: SettingsListController?
    
    private var models = [Section]()
    
    // MARK: - UI
    
    lazy var list: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsListTableViewCell.self,
                           forCellReuseIdentifier: SettingsListTableViewCell.identifier)
        return tableView
    }()
  
    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        
    }
    
    private func setupHierarchy() {
        addSubview(list)
    }
    
    private func setupLayout() {
        list.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension SettingsListView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Setup sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) && (indexPath.row == 0) {
            return 80
        } else {
            return 44
        }
    }
    
    // MARK: - Setup cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = list.dequeueReusableCell(withIdentifier: SettingsListTableViewCell.identifier,
                                                  for: indexPath) as? SettingsListTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: models[indexPath.section].cells[indexPath.row], controller: self.controller)
        return cell
    }
    
    // MARK: - Open deail and throw data
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.deselectRow(at: indexPath, animated: true)
        controller?.selectedCell(at: indexPath)
    }
}
