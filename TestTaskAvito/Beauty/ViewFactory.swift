//
//  MainViewFactory.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class ViewFactory {
    // MARK: - UILabel
    func createLabel(
        text: String,
        font: UIFont,
        textColor: UIColor,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
    
    // MARK: - UIButton
    func createButton(
        title: String,
        font: UIFont,
        titleColor: UIColor,
        backgroundColor: UIColor,
        cornerRadius: CGFloat = 8
    ) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        return button
    }
    
    // MARK: - UITextField
    func createTextField(
        placeholder: String,
        placeholderColor: UIColor = UIColor(color: .base10),
        font: UIFont = TextStyle.bodyMedium.font,
        textColor: UIColor = UIColor(color: .base0),
        backgroundColor: UIColor = UIColor(color: .base40),
        cornerRadius: CGFloat = 16,
        leftImageView: UIImageView
    ) -> UITextField {
        let textField = UITextField()
        textField.font = font
        textField.tintColor = UIColor(color: .base0)
        textField.textColor = textColor
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = cornerRadius
        textField.leftView = setUpLeftView(imageView: leftImageView)
        textField.leftViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor
            ]
        )
        
        textField.setHeight(48)
        return textField
    }
    
    // MARK: - UIImageView
    func createImageView(
        image: UIImage,
        contentMode: UIView.ContentMode = .scaleAspectFill,
        cornerRadius: CGFloat = 0,
        clipsToBounds: Bool = true
    ) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = contentMode
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = clipsToBounds
        return imageView
    }
    
    // MARK: - Private methods
    private func setUpLeftView(imageView: UIImageView) -> UIView {
        let leftView: UIView = UIView()
        leftView.setWidth(48)
        leftView.setHeight(20)
        
        imageView.tintColor = UIColor(color: .base10)
        
        leftView.addSubview(imageView)
        imageView.pinVertical(to: leftView)
        imageView.pinRight(to: leftView, 8)
        return leftView
    }
}
