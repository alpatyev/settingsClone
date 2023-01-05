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
    
    private lazy var subtitleOrBadge = UILabel()
    
    private lazy var rightSubview = UIView()
    
    private lazy var switcher = UISwitch()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupHierarchy()
        updateSubviews(contentView.frame)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
        } else if let badgeCount = internalData.badges {
            setupBadges(with: badgeCount)
        } else if let subtitleText = internalData.subtitle {
            setupSubtitle(with: subtitleText)
        }
    }
    

    private func setupImage(_ frame: CGRect) {
        let imageEdge = frame.height * 0.75
        
        if let icon = UIImage.init(named: internalData.image) {
            leftImage.image = icon
        } else {
            leftImage.image = UIImage.init(named: "default")
        }
        leftImage.clipsToBounds = true
        leftImage.layer.cornerRadius = isLoginCell ? imageEdge / 2 : 8
        
        leftImage.snp.makeConstraints { make in
            make.width.height.equalTo(imageEdge)
            make.left.equalTo(contentView).offset(divider)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupMainTitle() {
        mainTitle.text = internalData.title
        mainTitle.font = .systemFont(ofSize: 17, weight: .regular)
        
        mainTitle.snp.makeConstraints { make in
            make.left.equalTo(leftImage.snp.right).offset(divider)
            make.right.equalTo(rightSubview)
            make.height.equalTo(contentView).multipliedBy(isLoginCell ? 0.32 : 1)
            make.bottom.equalTo(contentView).multipliedBy(isLoginCell ? 0.5 : 1)
        }
    }
    
    private func setupRightSubview() {
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
        switcher.snp.makeConstraints { make in
            make.centerY.equalTo(rightSubview)
            make.right.equalTo(rightSubview).inset(divider)
        }
    }
    
    private func setupBadges(with count: Int) {
        let edge = contentView.frame.height * 0.56
        
        subtitleOrBadge.backgroundColor = .red
        subtitleOrBadge.textColor = .white
        subtitleOrBadge.textAlignment = .center
        subtitleOrBadge.text = "\(count)"
        
        subtitleOrBadge.clipsToBounds = true
        subtitleOrBadge.layer.masksToBounds = true
        subtitleOrBadge.layer.cornerRadius = edge / 2
        
        rightSubview.addSubview(subtitleOrBadge)
        subtitleOrBadge.snp.makeConstraints { make in
            make.width.height.equalTo(edge)
            make.right.equalTo(contentView)
            make.centerY.equalTo(contentView)
        }
    }
    
    private func setupSubtitle(with text: String) {
        subtitleOrBadge.text = text

        if isLoginCell {
            subtitleOrBadge.textColor = .black
            subtitleOrBadge.textAlignment = .left
            subtitleOrBadge.font = .systemFont(ofSize: 13, weight: .regular)
            mainTitle.font = .systemFont(ofSize: 22, weight: .regular)

            contentView.addSubview(subtitleOrBadge)
            subtitleOrBadge.snp.makeConstraints { make in
                make.left.equalTo(leftImage.snp.right).offset(divider)
                make.right.equalTo(rightSubview)
                make.height.equalTo(contentView).multipliedBy(0.32)
                make.top.equalTo(mainTitle.snp.bottom)
            }
        } else {
            subtitleOrBadge.textColor = .gray
            subtitleOrBadge.textAlignment = .right
            subtitleOrBadge.font = .systemFont(ofSize: 17, weight: .regular)
            
            rightSubview.addSubview(subtitleOrBadge)
            subtitleOrBadge.snp.makeConstraints { make in
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
    }
}

