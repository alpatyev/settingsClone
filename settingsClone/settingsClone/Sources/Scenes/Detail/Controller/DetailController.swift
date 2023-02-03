//
//  DetailController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/5/23.
//

import UIKit
import SnapKit

class DetailController: UIViewController {
    
    var model: DetalModel? {
        didSet {
            detailView?.updateAnimation(with: model?.isFlipping ?? false)
        }
    }
    
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        view = DetailView()
    }
 
    
    // MARK: - Confguration
            
    public func setupData(with model: DetalModel) {
        self.model = model
        navigationItem.title = model.title
        detailView?.configure(with: model.image, with: self)
    }
    
    // MARK: - User actions and updates
    
    public func imageTapped() {
        model?.isFlipping.toggle()
    }
}
