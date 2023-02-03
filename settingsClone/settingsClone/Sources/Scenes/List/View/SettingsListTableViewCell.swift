//
//  SettingsListTableViewCell.swift
//  settingsClone
//
//  Created by Nikita Alpatiev on 1/4/23.
//

import UIKit

final class SettingsListTableViewCell: UITableViewCell {
    
    // MARK: - Cell type ID
    
    static let identifier = "settings"
    
    // MARK: - Private properties
    
    private var controller: SettingsListController?
    private var model = Cell(image: "default", title: "") {
        didSet {
            accessoryType = model.switcher == nil ? .disclosureIndicator : .none
        }
    }
    
    private var isLoginCell: Bool {
        model.image == "account" ? true : false
    }
        
    
    // MARK: - UI
    
    private var divider = UIScreen.main.bounds.width * 0.035
    
    private lazy var leftImage = UIImageView()
    
    private lazy var mainTitle = UILabel()
        
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
    
    public func configure(with recieved: Cell?, controller: SettingsListController?) {
        guard let model = recieved else {
            return
        }
        self.model = model
        self.controller = controller
    }
    
    // MARK: - Setups and updates UI
    
    private func setupHierarchy() {
        switcher.removeFromSuperview()
        subtitle.removeFromSuperview()
        badges.removeFromSuperview()
        
        contentView.addSubview(leftImage)
        contentView.addSubview(mainTitle)
    }
    
    private func updateSubviews(_ frame: CGRect) {
        setupImage(frame)
        setupMainTitle()
        setupRightSubview()
        
        separatorInset.left = mainTitle.frame.minX
    }
    
    private func setupImage(_ frame: CGRect) {
        let imageEdge = frame.height * 0.64
        
        if let icon = UIImage.init(named: model.image) {
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
        mainTitle.text = model.title
        mainTitle.font = .systemFont(ofSize: 17, weight: .regular)
        
        mainTitle.snp.removeConstraints()
        mainTitle.snp.makeConstraints { make in
            make.left.equalTo(leftImage.snp.right).offset(divider)
            make.right.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(isLoginCell ? 0.32 : 1)
            make.bottom.equalTo(contentView).multipliedBy(isLoginCell ? 0.5 : 1)
        }
    }
    
    private func setupRightSubview() {
        if let switchState = model.switcher {
            setupSwitcher(with: switchState)
        } else if let subtitleText = model.subtitle {
            setupSubtitle(with: subtitleText)
        } else if let badgeCount = model.badges {
            setupBadges(with: badgeCount)
        }
    }
    
    private func setupSwitcher(with state: Bool) {
        switcher.isOn = state
        switcher.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        
        contentView.addSubview(switcher)
        switcher.snp.removeConstraints()
        switcher.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.width.lessThanOrEqualTo(contentView.frame.height)
            make.right.equalTo(contentView).inset(divider * 2)
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
        
        contentView.addSubview(badges)
        badges.snp.removeConstraints()
        badges.snp.makeConstraints { make in
            make.width.height.equalTo(contentView.snp.height).multipliedBy(0.56)
            make.right.equalTo(contentView).inset(divider)
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
                make.right.equalTo(contentView)
                make.height.equalTo(contentView).multipliedBy(0.32)
                make.top.equalTo(mainTitle.snp.bottom)
            }
        } else {
            subtitle.textColor = .gray
            subtitle.textAlignment = .right
            subtitle.font = .systemFont(ofSize: 17, weight: .regular)
            
            contentView.addSubview(subtitle)
            contentView.snp.removeConstraints()
            subtitle.snp.makeConstraints { make in
                make.left.equalTo(leftImage.snp.right)
                make.right.equalTo(contentView).inset(divider / 2)
                make.height.equalTo(contentView)
                make.centerY.equalTo(contentView)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func switchToggled() {
        guard let table = superview as? UITableView else { return }
        controller?.switchChanged(at: table.indexPath(for: self), with: switcher.isOn)
        
        print("\(model.title) is \(switcher.isOn ? "On": "Off")")
    }
}
