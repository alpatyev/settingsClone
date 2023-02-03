//
//  DetailController.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/5/23.
//

import UIKit
import SnapKit

class DetailController: UIViewController {
    
    private var isPulsing = false
    
    // MARK: - UI
    
    private lazy var icon = UIImageView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView(){
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handle))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupHierarchy() {
        view.addSubview(icon)
    }
    
    private func setupLayout() {
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(view.snp.width).multipliedBy(0.4)
            make.center.equalToSuperview()
        }
    }
    
    public func setupTitle(_ text: String) {
        navigationItem.title = text
    }
    
    public func setupImage(from name: String) {
        guard let image = UIImage(named: name) else {
            return
        }
        icon.image = image
        icon.clipsToBounds = true
        icon.layer.cornerRadius = view.frame.width * 0.05
    }
    
    // MARK: - Actions
    
    @objc private func handle(sender: UITapGestureRecognizer) {
        let spinX = CABasicAnimation(keyPath: "transform.scale.x")
        spinX.duration = 1.6
        spinX.fromValue = 1
        spinX.toValue = -1
        spinX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        spinX.repeatCount = .greatestFiniteMagnitude
        spinX.autoreverses = true
        
        if !isPulsing {
            isPulsing = true
            icon.layer.add(spinX, forKey: nil)
        } else {
            isPulsing = false
            icon.layer.removeAllAnimations()
        }
    }
}

