//
//  CategoryCell.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class CategoryCell: UITableViewCell {
    // MARK: - Constants
    private enum Constant {
        enum ReuseId {
            static let value: String = "CategoryCell"
        }
        
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum Title {
            static let leftOffset: CGFloat = 16
        }
        
        enum CheckView {
            static let image: UIImage? = UIImage(systemName: "checkmark.circle.fill")
            static let rightOffset: CGFloat = 16
            static let width: CGFloat = 24
            static let height: CGFloat = 24
        }
    }
    
    static let reuseId: String = Constant.ReuseId.value
    
    private var titleLabel: UILabel = UILabel()
    private let checkView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
    func showCheckImage() {
        checkView.isHidden = false
    }
    
    private func setUp() {
        self.backgroundColor = .clear
        
        setUpTitleLabel()
        setUpCheckView()
    }
    
    private func setUpTitleLabel() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            font: TextStyle.bodyMedium.font,
            textColor: UIColor(color: .base0)
        )
        
        contentView.addSubview(titleLabel)
        titleLabel.pinCenterY(to: contentView)
        titleLabel.pinLeft(to: contentView, Constant.Title.leftOffset)
    }
    
    private func setUpCheckView() {
        checkView.image = Constant.CheckView.image
        checkView.tintColor = UIColor(color: .base0)
        checkView.isHidden = true
        
        contentView.addSubview(checkView)
        checkView.pinCenterY(to: contentView)
        checkView.pinRight(to: contentView, Constant.CheckView.rightOffset)
        checkView.setWidth(Constant.CheckView.width)
        checkView.setHeight(Constant.CheckView.height)
    }
}
