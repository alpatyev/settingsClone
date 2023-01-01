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
    
    private func setupHierarchy() {}
    
    // MARK: - Setup layout
    
    private func setupLayout() {}
    
    // MARK: - Actions

}

