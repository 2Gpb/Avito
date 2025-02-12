//
//  SearchQueryCell.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class SearchQueryCell: UITableViewCell {
    // MARK: - ReuseId
    static let reuseId: String = "SearchQueryCell"
    
    // MARK: - UI Components
    private let leftImageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private let rightImageView: UIImageView = UIImageView()
    private let separatorView: UIView = UIView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(query: String) {
        titleLabel.text = query
    }
    
    // MARK: - SetUp
    private func setUp() {
        self.backgroundColor = .clear
        
        setUpLeftImageView()
        setUpRightImageView()
        setUpTitleLabel()
        setUpSeparatorView()
    }
    
    private func setUpLeftImageView() {
        leftImageView.image = UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
        
        leftImageView.tintColor = UIColor(color: .base0)
        
        contentView.addSubview(leftImageView)
        leftImageView.pinTop(to: contentView, 16)
        leftImageView.pinLeft(to: contentView, 16)
        leftImageView.setHeight(20)
        leftImageView.setWidth(20)
    }
    
    private func setUpRightImageView() {
        rightImageView.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
        rightImageView.tintColor = UIColor(color: .base0)
        
        contentView.addSubview(rightImageView)
        rightImageView.pinTop(to: contentView, 16)
        rightImageView.pinRight(to: contentView, 16)
        rightImageView.setHeight(18)
        rightImageView.setWidth(11)
    }
    
    private func setUpTitleLabel() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            font: TextStyle.body.font,
            textColor: UIColor(color: .base0)
        )
        
        titleLabel.numberOfLines = 1
        
        contentView.addSubview(titleLabel)
        titleLabel.pinTop(to: contentView, 16)
        titleLabel.pinLeft(to: leftImageView.trailingAnchor, 16)
        titleLabel.pinRight(to: rightImageView.leadingAnchor, 16)
    }
    
    private func setUpSeparatorView() {
        separatorView.backgroundColor = UIColor(color: .base40)
        
        contentView.addSubview(separatorView)
        separatorView.pinBottom(to: contentView)
        separatorView.pinLeft(to: titleLabel)
        separatorView.pinRight(to: contentView)
        separatorView.setHeight(1)
    }
}
