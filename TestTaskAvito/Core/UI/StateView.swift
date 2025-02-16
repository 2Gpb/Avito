//
//  ErrorState.swift
//  TestTaskAvito
//
//  Created by Peter on 16.02.2025.
//

import UIKit

final class StateView: UIView {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum Image {
            static let bottomOffset: CGFloat = 16
            static let height: CGFloat = 72
            static let width: CGFloat = 80
        }
        
        enum Description {
            static let top: CGFloat = 12
        }
    }
    
    // MARK: - Private fields
    private let imageView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    init(image: UIImage?, title: String, description: String) {
        super.init(frame: .zero)
        setUp()
        self.imageView.image = image
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = UIColor(color: .base70)
        
        setUpTitle()
        setUpImageView()
        setUpDescription()
    }
    
    private func setUpTitle() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            font: TextStyle.titleLarge.font,
            textColor: UIColor(color: .base0)
        )
        
        addSubview(titleLabel)
        titleLabel.pinCenterX(to: self)
        titleLabel.pinCenterY(to: self)
    }
    
    private func setUpImageView() {
        imageView.tintColor = UIColor(color: .base10)
        
        addSubview(imageView)
        imageView.pinBottom(to: titleLabel.topAnchor, Constant.Image.bottomOffset)
        imageView.pinCenterX(to: self)
        imageView.setHeight(Constant.Image.height)
        imageView.setWidth(Constant.Image.width)
    }
    
    private func setUpDescription() {
        descriptionLabel = ViewFactory.shared.setUpLabel(
            label: descriptionLabel,
            font: TextStyle.bodySmallMedium.font,
            textColor: UIColor(color: .base10)
        )
        
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constant.Description.top)
        descriptionLabel.pinCenterX(to: self)
    }
}
