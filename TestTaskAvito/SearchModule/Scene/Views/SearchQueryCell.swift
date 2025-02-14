//
//  SearchQueryCell.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class SearchQueryCell: UITableViewCell {
    // MARK: - Constants
    private enum Constant {
        enum ReuseId {
            static let value: String = "SearchQueryCell"
        }
        
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum LeftImage {
            static let topOffset: CGFloat = 16
            static let leftOffset: CGFloat = 16
            static let size: CGFloat = 20
            static let image: UIImage? = UIImage(
                systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .medium,
                    scale: .default
                )
            )
        }
        
        enum RightImage {
            static let topOffset: CGFloat = 16
            static let rightOffset: CGFloat = 16
            static let height: CGFloat = 18
            static let width: CGFloat = 11
            static let image: UIImage? = UIImage(
                systemName: "chevron.right",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .medium,
                    scale: .default
                )
            )
        }
        
        enum Title {
            static let numberOfLines: Int = 1
            static let topOffset: CGFloat = 16
            static let horizontalOffset: CGFloat = 16
        }
        
        enum Separator {
            static let height: CGFloat = 1
        }
    }
    
    // MARK: - ReuseId
    static let reuseId: String = Constant.ReuseId.value
    
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
        fatalError(Constant.Error.message)
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
        leftImageView.image = Constant.LeftImage.image
        leftImageView.tintColor = UIColor(color: .base0)
        
        contentView.addSubview(leftImageView)
        leftImageView.pinTop(to: contentView, Constant.LeftImage.topOffset)
        leftImageView.pinLeft(to: contentView, Constant.LeftImage.leftOffset)
        leftImageView.setHeight(Constant.LeftImage.size)
        leftImageView.setWidth(Constant.LeftImage.size)
    }
    
    private func setUpRightImageView() {
        rightImageView.image = Constant.RightImage.image
        rightImageView.tintColor = UIColor(color: .base0)
        
        contentView.addSubview(rightImageView)
        rightImageView.pinTop(to: contentView, Constant.RightImage.topOffset)
        rightImageView.pinRight(to: contentView, Constant.RightImage.rightOffset)
        rightImageView.setHeight(Constant.RightImage.height)
        rightImageView.setWidth(Constant.RightImage.width)
    }
    
    private func setUpTitleLabel() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            font: TextStyle.body.font,
            textColor: UIColor(color: .base0)
        )
        
        titleLabel.numberOfLines = Constant.Title.numberOfLines
        
        contentView.addSubview(titleLabel)
        titleLabel.pinTop(to: contentView, Constant.Title.topOffset)
        titleLabel.pinLeft(to: leftImageView.trailingAnchor, Constant.Title.horizontalOffset)
        titleLabel.pinRight(to: rightImageView.leadingAnchor, Constant.Title.horizontalOffset)
    }
    
    private func setUpSeparatorView() {
        separatorView.backgroundColor = UIColor(color: .base40)
        
        contentView.addSubview(separatorView)
        separatorView.pinBottom(to: contentView)
        separatorView.pinLeft(to: titleLabel)
        separatorView.pinRight(to: contentView)
        separatorView.setHeight(Constant.Separator.height)
    }
}
