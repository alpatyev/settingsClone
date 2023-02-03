//
//  DetailView.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 2/3/23.
//

import UIKit

class DetailView: UIView {
    
    // MARK: - Private properties
    
    private var controller: DetailController?
    
    // MARK: - UI
    
    private lazy var icon = UIImageView()
    
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
    
    // MARK: - Configuration
    
    public func configure(with image: String, with controller: DetailController) {
        guard let image = UIImage(named: image) else { return }
        icon.image = image
        icon.clipsToBounds = true
        icon.layer.cornerRadius = frame.width * 0.05
        
        self.controller = controller
    }
    
    public func updateAnimation(with state: Bool) {
        state ? stopAnimation() : addAnimation()
    }
    
    // MARK: - Actions
    
    @objc private func handle(sender: UITapGestureRecognizer) {
        controller?.imageTapped()
    }
    
    private func addAnimation() {
        let spinX = CABasicAnimation(keyPath: "transform.scale.x")
        spinX.duration = 1.6
        spinX.fromValue = 1
        spinX.toValue = -1
        spinX.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        spinX.repeatCount = .greatestFiniteMagnitude
        spinX.autoreverses = true
        icon.layer.add(spinX, forKey: nil)
    }
    
    private func stopAnimation() {
        icon.layer.removeAllAnimations()
    }
}
