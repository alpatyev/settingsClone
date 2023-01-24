//
//  DetailViewController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/5/23.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private var cellModel: Cell? {
        didSet {
            updateSubviews()
        }
    }
    
    // MARK: - Configuration
    
    public func configure(with recieved: Cell?) {
        guard let model = recieved else {
            return
        }
        cellModel = model
    }
    
    private func updateSubviews() {
        guard let cell = cellModel else {
            return
        }
        let detailView = DetailView()
        detailView.setupImage(from: cell.image)
        view = detailView
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = cell.title
    }
}

