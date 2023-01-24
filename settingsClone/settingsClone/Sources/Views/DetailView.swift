//
//  DetailView.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/24/23.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Helpers

    private var isRotating = false
    
    // MARK: - UI
    
    private lazy var icon = UIImageView()
    
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
    
    // MARK: - Setups
    
    private func setupView(){
        backgroundColor = .white
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handle))
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    private func setupHierarchy() {
        addSubview(icon)
    }
    
    private func setupLayout() {
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(snp.width).multipliedBy(0.4)
            make.center.equalToSuperview()
        }
    }
    
    public func setupImage(from name: String) {
        guard let image = UIImage(named: name) else {
            return
        }
        icon.image = image
        icon.clipsToBounds = true
        icon.layer.cornerRadius = frame.width * 0.05
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
        
        if !isRotating {
            isRotating = true
            icon.layer.add(spinX, forKey: nil)
        } else {
            isRotating = false
            icon.layer.removeAllAnimations()
        }
    }
}
