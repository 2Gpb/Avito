//
//  MainViewFactory.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class MainViewFactory {
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
        font: UIFont,
        textColor: UIColor,
        borderStyle: UITextField.BorderStyle = .roundedRect
    ) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = font
        textField.textColor = textColor
        textField.borderStyle = borderStyle
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
}


