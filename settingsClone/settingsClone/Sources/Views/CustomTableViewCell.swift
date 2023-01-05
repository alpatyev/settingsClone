//
//  CustomTableViewCell.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/4/23.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier = "settings"
    
    private var internalData = Cell(image: "default", title: "") {
        didSet {
            accessoryType = internalData.switcher == nil ? .disclosureIndicator : .none
        }
    }
    
    private var isLoginCell: Bool {
        internalData.image == "account" ? true : false
    }
    
    private var divider = UIScreen.main.bounds.width * 0.035
    
    // MARK: - UI
    
    private lazy var leftImage = UIImageView()
    
    private lazy var mainTitle = UILabel()
    
    private lazy var rightSubview = UIView()
    
    private lazy var subtitle = UILabel()
    
    private lazy var badges = UILabel()
    
    private lazy var switcher = UISwitch()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupHierarchy()
        updateSubviews(frame)
    }
    
    // MARK: - Get model data
    
    public func configure(with recieved: Cell?) {
        guard let model = recieved else {
            return
        }
        internalData = model
    }
    
    // MARK: - Setups and updates UI
    
    private func setupHierarchy() {
        switcher.removeFromSuperview()
        subtitle.removeFromSuperview()
        badges.removeFromSuperview()
        
        contentView.addSubview(leftImage)
        contentView.addSubview(mainTitle)
        contentView.addSubview(rightSubview)
    }
    
    private func updateSubviews(_ frame: CGRect) {
        setupImage(frame)
        setupMainTitle()
        setupRightSubview()
        
        if let switchState = internalData.switcher {
            setupSwitcher(with: switchState)
        } else if let subtitleText = internalData.subtitle {
            setupSubtitle(with: subtitleText)
        } else if let badgeCount = internalData.badges {
            setupBadges(with: badgeCount)
        } else {
            rightSubview.subviews.forEach { $0.removeFromSuperview() }
        }
    }
    
    private func setupImage(_ frame: CGRect) {
        let imageEdge = frame.height * 0.64
        
        if let icon = UIImage.init(named: internalData.image) {
            leftImage.image = icon
        } else {
            leftImage.image = UIImage.init(named: "default")
        }
        
        leftImage.contentMode = .scaleAspectFill
        leftImage.clipsToBounds = true
        leftImage.layer.cornerRadius = isLoginCell ? imageEdge / 2 : 8
        
        leftImage.snp.removeConstraints()
        leftImage.snp.makeConstraints { make in
            make.width.height.equalTo(imageEdge)
            make.left.equalTo(contentView).offset(divider)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupMainTitle() {
        mainTitle.text = internalData.title
        mainTitle.font = .systemFont(ofSize: 17, weight: .regular)
        
        mainTitle.snp.removeConstraints()
        mainTitle.snp.makeConstraints { make in
            make.left.equalTo(leftImage.snp.right).offset(divider)
            make.right.equalTo(rightSubview)
            make.height.equalTo(contentView).multipliedBy(isLoginCell ? 0.32 : 1)
            make.bottom.equalTo(contentView).multipliedBy(isLoginCell ? 0.5 : 1)
        }
    }
    
    private func setupRightSubview() {
        rightSubview.snp.removeConstraints()
        rightSubview.snp.makeConstraints { make in
            make.height.equalTo(contentView)
            make.width.equalTo(contentView).multipliedBy(0.25)
            make.right.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupSwitcher(with state: Bool) {
        switcher.isOn = state
        switcher.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        
        rightSubview.addSubview(switcher)
        switcher.snp.removeConstraints()
        switcher.snp.makeConstraints { make in
            make.centerY.equalTo(rightSubview)
            make.width.lessThanOrEqualTo(contentView.frame.height)
            make.right.equalTo(rightSubview).inset(divider * 2)
        }
    }
    
    private func setupBadges(with count: Int) {
        badges.backgroundColor = .red
        badges.textColor = .white
        badges.textAlignment = .center
        badges.text = "\(count)"
        
        badges.clipsToBounds = true
        badges.layer.masksToBounds = true
        badges.layer.cornerRadius = contentView.frame.height * 0.28
        
        rightSubview.addSubview(badges)
        badges.snp.removeConstraints()
        badges.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.height).multipliedBy(0.56)
            make.right.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupSubtitle(with text: String) {
        subtitle.text = text

        if isLoginCell {
            subtitle.textColor = .black
            subtitle.textAlignment = .left
            subtitle.font = .systemFont(ofSize: 13, weight: .regular)
            mainTitle.font = .systemFont(ofSize: 22, weight: .regular)

            contentView.addSubview(subtitle)
            subtitle.snp.removeConstraints()
            subtitle.snp.makeConstraints { make in
                make.left.equalTo(leftImage.snp.right).offset(divider)
                make.right.equalTo(rightSubview)
                make.height.equalTo(contentView).multipliedBy(0.32)
                make.top.equalTo(mainTitle.snp.bottom)
            }
        } else {
            subtitle.textColor = .gray
            subtitle.textAlignment = .right
            subtitle.font = .systemFont(ofSize: 17, weight: .regular)
            
            rightSubview.addSubview(subtitle)
            rightSubview.snp.removeConstraints()
            subtitle.snp.makeConstraints { make in
                make.left.equalTo(leftImage.snp.right)
                make.right.equalTo(contentView)
                make.height.equalTo(contentView)
                make.centerY.equalTo(contentView)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func switchToggled() {
        internalData.switcher = switcher.isOn
        SettingsModel.updateCell(from: indexPath, cell: internalData)
        
        print("\(internalData.title) is \(switcher.isOn ? "On": "Off")")
    }
}

