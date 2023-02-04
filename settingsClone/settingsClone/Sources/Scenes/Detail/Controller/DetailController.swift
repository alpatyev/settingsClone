//
//  DetailController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/5/23.
//

import UIKit

class DetailController: UIViewController {
    
    var model: DetalModel?
    
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        view = DetailView()
        
        detailView?.configure(with: model?.image ?? "", with: self)
    }
 
    // MARK: - Confguration
            
    public func setupData(with model: DetalModel) {
        self.model = model
        navigationItem.title = model.title
    }
    
    // MARK: - User actions and updates
    
    public func imageTapped() {
        model?.isFlipping.toggle()
        detailView?.updateAnimation(with: model?.isFlipping ?? false)
    }
}
