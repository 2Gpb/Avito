//
//  FiltersViewCell.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class FiltersViewCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message: String = "init(coder:) has not been implemented"
        }
        
        enum ReuseIdentifier {
            static let value: String = "FiltersViewCell"
        }
        
        enum TextFields {
            static let rightImage: UIImage? = UIImage(systemName: "chevron.down")
            static let categoryPlaceholder: String = "Category"
            static let pricePlaceholder: String = "Price"
            static let offset: CGFloat = 8
        }
        
        enum Views {
            static let width: CGFloat = 56
            static let height: CGFloat = 20
            static let rightOffset: CGFloat = 16
        }
        
        enum Buttons {
            static let resetTitle: String = "Reset"
            static let showTitle: String = "Show items"
            static let widthResetButton: CGFloat = 78
            static let topOffst: CGFloat = 12
            static let rightOffset: CGFloat = 12
        }
    }
    
    // MARK: - ReuseId
    static let reuseId: String = Constant.ReuseIdentifier.value
    
    // MARK: - Variables
    var openSelectCategory: (() -> Void)?
    var openPriceSelector: (() -> Void)?
    
    // MARK: - UI Components
    private var categoryTextField: UITextField = UITextField()
    private var priceTextField: UITextField = UITextField()
    private var showButton: UIButton = UIButton()
    private var resetButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    // MARK: - SetUp
    private func setUp() {
        setUpCategoryTextField()
        setUpPriceTextField()
        setUpResetButton()
        setUpShowButton()
    }
    
    private func setUpCategoryTextField() {
        let views = createLeftAndRightViews()
        categoryTextField = ViewFactory.shared.setUpTextField(
            textField: categoryTextField,
            placeholder: Constant.TextFields.categoryPlaceholder,
            font: TextStyle.bodySmall.font,
            leftView: views.leftView,
            rightView: views.rightView
        )
        
        categoryTextField.delegate = self
        
        contentView.addSubview(categoryTextField)
        categoryTextField.pinTop(to: contentView)
        categoryTextField.pinLeft(to: contentView)
        categoryTextField.setWidth((contentView.frame.width - Constant.TextFields.offset) / 2)
    }
    
    private func setUpPriceTextField() {
        let views = createLeftAndRightViews()
        priceTextField = ViewFactory.shared.setUpTextField(
            textField: priceTextField,
            placeholder: Constant.TextFields.pricePlaceholder,
            font: TextStyle.bodySmall.font,
            leftView: views.leftView,
            rightView: views.rightView
        )
        
        priceTextField.delegate = self
        
        contentView.addSubview(priceTextField)
        priceTextField.pinTop(to: contentView)
        priceTextField.pinRight(to: contentView)
        priceTextField.setWidth((contentView.frame.width - Constant.TextFields.offset) / 2)
    }
    
    private func createLeftAndRightViews() -> (leftView: UIView, rightView: UIView) {
        let leftView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        let imageView: UIImageView = UIImageView(image: Constant.TextFields.rightImage)
        imageView.tintColor = UIColor(color: .base0)
        let rightView = ViewFactory.shared.setUpViewForTextField(
            imageView: imageView,
            width: Constant.Views.width,
            height: Constant.Views.height,
            rightOffset: Constant.Views.rightOffset
        )
        
        return (leftView, rightView)
    }
    
    private func setUpResetButton() {
        resetButton = ViewFactory.shared.setUpButton(
            button: resetButton,
            title: Constant.Buttons.resetTitle,
            titleColor: UIColor(color: .base0),
            backgroundColor: .clear
        )
        
        contentView.addSubview(resetButton)
        resetButton.pinTop(to: priceTextField.bottomAnchor, Constant.Buttons.topOffst)
        resetButton.pinRight(to: contentView)
        resetButton.setWidth(Constant.Buttons.widthResetButton)
    }
    
    private func setUpShowButton() {
        showButton = ViewFactory.shared.setUpButton(
                button: showButton,
                title: Constant.Buttons.showTitle,
                titleColor: UIColor(color: .base80),
                backgroundColor: UIColor(color: .base0)
            )
        
        contentView.addSubview(showButton)
        showButton.pinTop(to: categoryTextField.bottomAnchor, Constant.Buttons.topOffst)
        showButton.pinLeft(to: contentView)
        showButton.pinRight(to: resetButton.leadingAnchor, Constant.Buttons.rightOffset)
    }
}

// MARK: - UITextFieldDelegate
extension FiltersViewCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == categoryTextField {
            textField.resignFirstResponder()
            openSelectCategory?()
            return false
        } else {
            textField.resignFirstResponder()
            openPriceSelector?()
            return false
        }
        
    }
}
