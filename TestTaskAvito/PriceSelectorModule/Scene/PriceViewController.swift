//
//  PriceViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class PriceViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum Sheet {
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 212
        }
        
        enum WrapView {
            static let height: CGFloat = 68
        }
        
        enum Title {
            static let text = "Price"
            static let bottomOffset: CGFloat = 17
        }
        
        enum CloseButton {
            static let bottomOffset: CGFloat = 4
            static let leftOffset: CGFloat = 5
            static let width: CGFloat = 44
            static let height: CGFloat = 44
            static let image: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .default)
            )
        }
        
        enum TextFields {
            static let fromPriceLabel: String = "From"
            static let topOffset: CGFloat = 12
            static let horizontalOffset: CGFloat = 16
            static let toPriceLabel: String = "To"
            static let offset: CGFloat = 40
            static let rightButtonFrame: CGRect = CGRect(x: 4, y: 3, width: 15, height: 14)
            static let defaultText: String = " $"
            static let clearImage: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
            )
            
            static let bigLeftViewFrame: CGRect = CGRect(x: 0, y: 0, width: 54, height: 22)
            static let smallLeftViewFrame: CGRect = CGRect(x: 0, y: 0, width: 36, height: 22)
            static let leftViewTitleFrame: CGRect = CGRect(x: 15, y: 0, width: 40, height: 22)
            static let rightViewFrame: CGRect = CGRect(x: 0, y: 0, width: 38, height: 20)
            static let maxLength: Int = 10
        }
        
        enum ApplyButton {
            static let title: String = "Apply"
            static let topOffset: CGFloat = 24
            static let horizontalOffset: CGFloat = 16
        }
    }
    
    // MARK: - Private fields
    private let interactor: PriceBusinessLogic
    
    // MARK: - UI Components
    private let wrapView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton()
    private var fromPriceTextField: UITextField = UITextField()
    private let fromClearButton: UIButton = UIButton(type: .system)
    private let toClearButton: UIButton = UIButton(type: .system)
    private var toPriceTextField: UITextField = UITextField()
    private var applyButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(interactor: PriceBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Private methods
    private func updateText(textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else { return }
        let cleanedText = text.replacingOccurrences(of: " $", with: "")
        let finalText = cleanedText + " $"
        textField.text = finalText
        
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: cleanedText.count) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = UIColor(color: .base80)
        fromPriceTextField.becomeFirstResponder()
        
        setupSheetStyle()
        setUpWrapView()
        setUpTitleLabel()
        setUpCloseButton()
        setUpFromPriceTextField()
        setUpToPriceTextField()
        setUpApplyButton()
    }
    
    private func setupSheetStyle() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in return Constant.Sheet.height })]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = Constant.Sheet.cornerRadius
        }
    }
    
    private func setUpWrapView() {
        wrapView.backgroundColor = UIColor(color: .base70)
        
        view.addSubview(wrapView)
        wrapView.pinTop(to: view)
        wrapView.pinHorizontal(to: view)
        wrapView.setHeight(Constant.WrapView.height)
    }
    
    private func setUpTitleLabel() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            text: Constant.Title.text,
            font: TextStyle.bodyBold.font,
            textColor: UIColor(color: .base0),
            alignment: .center
        )
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinCenterX(to: wrapView)
        titleLabel.pinBottom(to: wrapView, Constant.Title.bottomOffset)
    }
    
    private func setUpCloseButton() {
        closeButton.setImage(
            Constant.CloseButton.image,
            for: .normal
        )
        
        closeButton.tintColor = UIColor(color: .base0)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        wrapView.addSubview(closeButton)
        closeButton.pinBottom(to: wrapView, Constant.CloseButton.bottomOffset)
        closeButton.pinLeft(to: wrapView, Constant.CloseButton.leftOffset)
        closeButton.setWidth(Constant.CloseButton.width)
        closeButton.setHeight(Constant.CloseButton.height)
    }
    
    private func setUpFromPriceTextField() {
        fromClearButton.addTarget(self, action: #selector(fromClearButtonTapped), for: .touchUpInside)
        fromClearButton.isHidden = true
        let views = createLeftAndRightViews(button: fromClearButton, text: Constant.TextFields.fromPriceLabel)
        fromPriceTextField = ViewFactory.shared.setUpTextField(
            textField: fromPriceTextField,
            font: TextStyle.bodySmall.font,
            leftView: views.leftView,
            rightView: views.rightView
        )
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(fromPriceTapped))
        fromPriceTextField.addGestureRecognizer(gesture)
        fromPriceTextField.delegate = self
        fromPriceTextField.keyboardType = .numberPad
        fromPriceTextField.text = Constant.TextFields.defaultText
        updateText(textField: fromPriceTextField)
        
        view.addSubview(fromPriceTextField)
        fromPriceTextField.pinTop(to: wrapView.bottomAnchor, Constant.TextFields.topOffset)
        fromPriceTextField.pinLeft(to: view, Constant.TextFields.horizontalOffset)
        fromPriceTextField.setWidth((view.frame.width - Constant.TextFields.offset) / CGFloat(2))
    }
    
    private func setUpToPriceTextField() {
        toClearButton.addTarget(self, action: #selector(toClearButtonTapped), for: .touchUpInside)
        toClearButton.isHidden = true
        let views = createLeftAndRightViews(button: toClearButton, text: Constant.TextFields.toPriceLabel)
        toPriceTextField = ViewFactory.shared.setUpTextField(
            textField: toPriceTextField,
            font: TextStyle.bodySmall.font,
            leftView: views.leftView,
            rightView: views.rightView
        )
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toPriceTapped))
        toPriceTextField.addGestureRecognizer(gesture)
        toPriceTextField.delegate = self
        toPriceTextField.keyboardType = .numberPad
        toPriceTextField.text = Constant.TextFields.defaultText
        updateText(textField: toPriceTextField)
        
        view.addSubview(toPriceTextField)
        toPriceTextField.pinTop(to: wrapView.bottomAnchor, Constant.TextFields.topOffset)
        toPriceTextField.pinRight(to: view, Constant.TextFields.horizontalOffset)
        toPriceTextField.setWidth((view.frame.width - Constant.TextFields.offset) / CGFloat(2))
    }
    
    private func createLeftAndRightViews(button: UIButton, text: String) -> (leftView: UIView, rightView: UIView) {
        let leftView: UIView = UIView()
        if text.count <= 2 {
            leftView.frame = Constant.TextFields.smallLeftViewFrame
        } else {
            leftView.frame = Constant.TextFields.bigLeftViewFrame
        }
        
        leftView.backgroundColor = .clear
        var leftViewTitle: UILabel = UILabel()
        leftViewTitle = ViewFactory.shared.setUpLabel(
            label: leftViewTitle,
            text: text,
            font: TextStyle.bodySmall.font,
            textColor: UIColor(color: .base0)
        )
        
        leftView.addSubview(leftViewTitle)
        leftViewTitle.frame = Constant.TextFields.leftViewTitleFrame
        
        let rightView: UIView = UIView(frame: Constant.TextFields.rightViewFrame)
        rightView.backgroundColor = .clear
        button.tintColor = UIColor(color: .base0)
        button.setImage(Constant.TextFields.clearImage, for: .normal)
        
        rightView.addSubview(button)
        button.frame = Constant.TextFields.rightButtonFrame
        return (leftView, rightView)
    }
    
    private func setUpApplyButton() {
        applyButton = ViewFactory.shared.setUpButton(button: applyButton, title: Constant.ApplyButton.title)
        applyButton.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        
        view.addSubview(applyButton)
        applyButton.pinTop(to: fromPriceTextField.bottomAnchor, Constant.ApplyButton.topOffset)
        applyButton.pinHorizontal(to: view, Constant.ApplyButton.horizontalOffset)
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        interactor.closeScreen()
    }
    
    @objc
    private func applyButtonTapped() {
        interactor.closeScreen()
    }
    
    @objc
    private func fromClearButtonTapped() {
        fromClearButton.isHidden = true
        fromPriceTextField.text = Constant.TextFields.defaultText
        updateText(textField: fromPriceTextField)
    }
    
    @objc
    private func toClearButtonTapped() {
        toClearButton.isHidden = true
        toPriceTextField.text = Constant.TextFields.defaultText
        updateText(textField: toPriceTextField)
    }
    
    @objc
    private func toPriceTapped() {
        toPriceTextField.becomeFirstResponder()
    }
    
    @objc
    private func fromPriceTapped() {
        fromPriceTextField.becomeFirstResponder()
    }
}

// MARK: - UITextFieldDelegate
extension PriceViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength: Int
        
        if textField == fromPriceTextField {
            fromClearButton.isHidden = false
            maxLength = Constant.TextFields.maxLength
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            if newText.isEmpty {
                fromClearButton.isHidden = true
            }
        } else {
            toClearButton.isHidden = false
            maxLength = Constant.TextFields.maxLength + 1
            let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
            if newText.isEmpty {
                toClearButton.isHidden = true
            }
        }
        
        let currentLength = textField.text?.count ?? 0
        let newLength = currentLength + string.count - range.length
        return newLength <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateText(textField: textField)
    }
}
