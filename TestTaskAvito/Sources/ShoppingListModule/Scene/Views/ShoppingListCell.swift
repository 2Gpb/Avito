//
//  ShoppingListCell.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import UIKit

final class ShoppingListCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constant {
        enum ReuseId {
            static let value: String = "ShoppingListCell"
        }
        
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum ImageView {
            static let cornerRadius: CGFloat = 16
        }
        
        enum MoreButton {
            static let width: CGFloat = 36
            static let height: CGFloat = 28
            static let image = UIImage(
                systemName: "ellipsis",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .medium,
                    scale: .default
                )
            )
        }
        
        enum NameLabel {
            static let topOffset: CGFloat = 4
            static let horizontallyOffset: CGFloat = 16
        }
        
        enum PriceLabel {
            static let topOffset: CGFloat = 8
            static let leftOffset: CGFloat = 16
        }
        
        enum Counter {
            static let leftOffset: CGFloat = 16
            static let verticalInset: CGFloat = 0
            static let horizontalInset: CGFloat = 4
            static let buttonSize: CGFloat = 32
        }
    }
    
    // MARK: - ReuseId
    static let reuseId: String = Constant.ReuseId.value
    
    // MARK: - UI Components
    private let imageView: AsyncImageView = AsyncImageView()
    private let moreButton: UIButton = UIButton(type: .system)
    private var nameLabel: UILabel = UILabel()
    private var priceLabel: UILabel = UILabel()
    private var counterLabel: UILabel = UILabel()
    private var counter: UIView = UIView()
    
    var plusTapped: (() -> Void)?
    var minusTapped: (() -> Void)?
    
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
    func configure(with model: ShoppingListItemModel) {
        imageView.loadImage(path: model.image)
        nameLabel.text = model.name
        priceLabel.text = model.price
        counterLabel.text = "\(model.count)"
    }
    
    func setCount(_ count: Int) {
        counterLabel.text = "\(count)"
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = .clear
        
        setUpImageView()
        setUpMoreButton()
        setUpNameLabel()
        setUpPriceLabel()
        setUpCounter()
    }
    
    private func setUpImageView() {
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constant.ImageView.cornerRadius
        
        contentView.addSubview(imageView)
        imageView.pinVertical(to: contentView)
        imageView.pinLeft(to: contentView)
        imageView.setWidth(contentView.frame.height)
    }
    
    private func setUpMoreButton() {
        moreButton.setImage(Constant.MoreButton.image, for: .normal)
        moreButton.tintColor = UIColor(color: .base0)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(moreButton)
        moreButton.pinTop(to: contentView)
        moreButton.pinRight(to: contentView)
        moreButton.setWidth(Constant.MoreButton.width)
        moreButton.setHeight(Constant.MoreButton.height)
    }
    
    private func setUpNameLabel() {
        nameLabel = ViewFactory.shared.setUpLabel(
            label: nameLabel,
            font: TextStyle.bodySmall.font,
            textColor: UIColor(color: .base5)
        )
        
        contentView.addSubview(nameLabel)
        nameLabel.pinTop(to: contentView, Constant.NameLabel.topOffset)
        nameLabel.pinLeft(to: imageView.trailingAnchor, Constant.NameLabel.horizontallyOffset)
        nameLabel.pinRight(to: moreButton.leadingAnchor, Constant.NameLabel.horizontallyOffset)
    }
    
    private func setUpPriceLabel() {
        priceLabel = ViewFactory.shared.setUpLabel(
            label: priceLabel,
            font: TextStyle.bodyBold.font,
            textColor: UIColor(color: .base0)
        )
        
        contentView.addSubview(priceLabel)
        priceLabel.pinTop(to: nameLabel.bottomAnchor, Constant.PriceLabel.topOffset)
        priceLabel.pinLeft(to: imageView.trailingAnchor, Constant.PriceLabel.leftOffset)
    }
    
    private func setUpCounter() {
        counterLabel = ViewFactory.shared.setUpLabel(
            label: counterLabel,
            font: TextStyle.bodyBold.font,
            textColor: UIColor(color: .base0),
            alignment: .center
        )
        
        counter = ViewFactory.shared.setUpCounter(
            counter: counter,
            counterLabel: counterLabel,
            target: self,
            minusButtonTapped: #selector(minusCount),
            plusButtonTapped: #selector(plusCount),
            verticalInsets: Constant.Counter.verticalInset,
            horizontalInsets: Constant.Counter.horizontalInset,
            buttonSize: Constant.Counter.buttonSize,
            buttonImageScale: .small
        )
        
        contentView.addSubview(counter)
        counter.pinBottom(to: contentView)
        counter.pinLeft(to: imageView.trailingAnchor, Constant.Counter.leftOffset)
    }
    
    // MARK: - Actions
    @objc
    private func moreButtonTapped() {
        
    }
    
    @objc
    private func minusCount() {
        minusTapped?()
    }
    
    @objc
    private func plusCount() {
        plusTapped?()
    }
}
