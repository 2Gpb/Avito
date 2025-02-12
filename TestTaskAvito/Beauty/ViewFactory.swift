//
//  MainViewFactory.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class ViewFactory {
    // MARK: - Singleton
    static let shared = ViewFactory()
    
    // MARK: - UILabel
    func setUpLabel(
        label: UILabel,
        text: String = "",
        font: UIFont,
        textColor: UIColor,
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment
        return label
    }
    
    // MARK: - UIButton
    func setUpButton(
        button: UIButton,
        title: String,
        font: UIFont = TextStyle.bodySmallMedium.font,
        titleColor: UIColor = UIColor(color: .base80),
        backgroundColor: UIColor = UIColor(color: .base0),
        cornerRadius: CGFloat = 16
    ) -> UIButton {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        
        button.setHeight(48)
        return button
    }
    
    // MARK: - UITextField
    func setUpTextField(
        textField: UITextField,
        placeholder: String = "",
        placeholderColor: UIColor = UIColor(color: .base10),
        font: UIFont = TextStyle.bodySmallMedium.font,
        textColor: UIColor = UIColor(color: .base0),
        backgroundColor: UIColor = UIColor(color: .base40),
        cornerRadius: CGFloat = 16,
        leftView: UIView = UIView(),
        rightView: UIView = UIView()
    ) -> UITextField {
        textField.font = font
        textField.tintColor = UIColor(color: .base0)
        textField.textColor = textColor
        textField.backgroundColor = backgroundColor
        textField.layer.cornerRadius = cornerRadius
        textField.leftView = leftView
        textField.rightView = rightView
        textField.rightViewMode = .always
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
    
    func setUpViewForTextField(
        imageView: UIImageView,
        width: CGFloat,
        height: CGFloat,
        rightOffset: CGFloat
    ) -> UIView {
        let leftView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftView.addSubview(imageView)
        imageView.center = leftView.center
        return leftView
    }
}
