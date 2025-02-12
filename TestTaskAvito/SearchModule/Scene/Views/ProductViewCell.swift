//
//  ProductCollectionViewCell.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class ProductViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum ReuseIdentifier {
            static let value: String = "ProductCollectionViewCell"
        }
        
        enum ImageView {
            static let cornerRadius: CGFloat = 8
        }
        
        enum NameLabel {
            static let lines: Int = 2
            static let topOffset: CGFloat = 8
        }
        
        enum PriceLabel {
            static let lines: Int = 2
            static let topOffset: CGFloat = 8
        }
    }
    
    // MARK: - ReuseID
    static let reuseId: String = Constant.ReuseIdentifier.value
    
    // MARK: - UI Components
    private let image: UIImageView = UIImageView()
    private var name: UILabel = UILabel()
    private var price: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    // MARK: - Methods
    func configure(name: String, price: String) {
        self.name.text = name
        self.price.text = price
    }
    
    // MARK: - SetUp
    private func setUp() {
        contentView.backgroundColor = .clear
        
        setUpImageView()
        setUpNameLabel()
        setUpPriceLabel()
    }
    
    private func setUpImageView() {
        image.layer.cornerRadius = Constant.ImageView.cornerRadius
        image.clipsToBounds = true
        image.backgroundColor = UIColor(color: .base10)
        
        contentView.addSubview(image)
        image.pinTop(to: contentView)
        image.pinLeft(to: contentView)
        image.pinRight(to: contentView)
        image.setHeight(contentView.frame.width)
    }
    
    private func setUpNameLabel() {
        name = ViewFactory.shared.setUpLabel(
            label: name,
            font: TextStyle.body.font,
            textColor: UIColor(color: .base5)
        )
        
        name.numberOfLines = Constant.NameLabel.lines
        
        contentView.addSubview(name)
        name.pinTop(to: image.bottomAnchor, Constant.NameLabel.topOffset)
        name.pinLeft(to: contentView)
        name.pinRight(to: contentView)
    }
    
    private func setUpPriceLabel() {
        price = ViewFactory.shared.setUpLabel(
            label: price,
            font: TextStyle.bodyBold.font,
            textColor: UIColor(color: .base0)
        )
        
        price.numberOfLines = Constant.PriceLabel.lines
        
        contentView.addSubview(price)
        price.pinTop(to: name.bottomAnchor, Constant.PriceLabel.topOffset)
        price.pinLeft(to: contentView)
        price.pinRight(to: contentView)
    }
}
