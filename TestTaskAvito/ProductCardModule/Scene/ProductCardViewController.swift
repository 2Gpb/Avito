//
//  ProductCardViewControlle.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class ProductCardViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum BackButton {
            static let image: UIImage? = UIImage(systemName: "chevron.left")
            static let topOffset: CGFloat = 14
            static let leftOffset: CGFloat = 16
            static let width: CGFloat = 24
            static let height: CGFloat = 24
        }
        
        enum ShareButton {
            static let image: UIImage? = UIImage(systemName: "square.and.arrow.up")
            static let topOffset: CGFloat = 14
            static let rightOffset: CGFloat = 16
            static let width: CGFloat = 21
            static let height: CGFloat = 26
        }
        
        enum ProductImageView {
            static let topOffset: CGFloat = 14
            static let heightDivider: CGFloat = 1.5
        }
        
        enum Stack {
            static let spacing: CGFloat = 13
            static let topOffset: CGFloat = 16
            static let horizontalOffset: CGFloat = 16
        }
        
        enum Labels {
            static let pricenumberOfLines: Int = 1
            static let nameNumberOfLines: Int = 1
            static let descriptionNumberOfLines: Int = 3
        }
        
        enum CategoryView {
            static let cornerRadius: CGFloat = 16
            static let numberOfLines: Int = 1
            static let horizontalOffset: CGFloat = 16
            static let verticalOffset: CGFloat = 10
        }
        
        enum AddButton {
            static let title: String = "Add to shopping list"
            static let topOffset: CGFloat = 20
            static let horizontalOffset: CGFloat = 16
        }
         
        enum Counter {
            static let topOffset: CGFloat = 24
            static let leftOffset: CGFloat = 16
            static let cornerRadius: CGFloat = 16
            static let verticalInset: CGFloat = 12
            static let buttonHorizontalOffset: CGFloat = 12
            static let labelHorizontalOffset: CGFloat = 4
            static let labelWidth: CGFloat = 36
            static let buttonSize: CGFloat = 24
            static let minusImage: UIImage? = UIImage(
                systemName: "minus",
                withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
            )
            
            static let plusImage: UIImage? = UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
            )
        }
        
        enum ToCartButton {
            static let title: String = "To the shopping list"
            static let topOffset: CGFloat = 24
            static let leftOffset: CGFloat = 12
            static let rightOffset: CGFloat = 16
        }
    }
    
    // MARK: - Private fields
    private let interactor: ProductCardBusinessLogic
    
    // MARK: - UI Components
    private let backButton: UIButton = UIButton(type: .system)
    private let shareButton: UIButton = UIButton(type: .system)
    private let productImageView: UIImageView = UIImageView()
    private var priceLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var categoryLabel: UILabel = UILabel()
    private let stackView: UIStackView = UIStackView()
    private var addButton: UIButton = UIButton(type: .system)
    private var counterLabel: UILabel = UILabel()
    private var toCartButton: UIButton = UIButton(type: .system)
    private let counter: UIView = UIView()
    
    // MARK: - Lifecycle
    init(interactor: ProductCardBusinessLogic) {
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
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = UIColor(color: .base80)
        
        setUpBackButton()
        setUpShareButton()
        setUpProductImageView()
        setUpInfoLabels()
        setUpCategoryView()
        setUpInfoStack()
        setUpAddButton()
        setUpCounter()
        setUpToCartButton()
    }
    
    private func setUpBackButton() {
        backButton.setImage(Constant.BackButton.image, for: .normal)
        backButton.tintColor = UIColor(color: .base0)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(backButton)
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.BackButton.topOffset)
        backButton.pinLeft(to: view, Constant.BackButton.leftOffset)
        backButton.setWidth(Constant.BackButton.width)
        backButton.setHeight(Constant.BackButton.height)
    }
    
    private func setUpShareButton() {
        shareButton.setImage(Constant.ShareButton.image, for: .normal)
        shareButton.tintColor = UIColor(color: .base0)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        view.addSubview(shareButton)
        shareButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.ShareButton.topOffset)
        shareButton.pinRight(to: view, Constant.ShareButton.rightOffset)
        shareButton.setWidth(Constant.ShareButton.width)
        shareButton.setHeight(Constant.ShareButton.height)
    }
    
    private func setUpProductImageView() {
        productImageView.backgroundColor = .gray
        
        view.addSubview(productImageView)
        productImageView.pinTop(to: backButton.bottomAnchor, Constant.ProductImageView.topOffset)
        productImageView.pinHorizontal(to: view)
        productImageView.setHeight(view.frame.width / Constant.ProductImageView.heightDivider)
    }
    
    private func setUpInfoStack() {
        stackView.axis = .vertical
        stackView.spacing = Constant.Stack.spacing
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.pinTop(to: productImageView.bottomAnchor, Constant.Stack.topOffset)
        stackView.pinHorizontal(to: view, Constant.Stack.horizontalOffset)
    }
    
    private func setUpInfoLabels() {
        priceLabel = ViewFactory.shared.setUpLabel(
            label: priceLabel,
            text: "39$",
            font: TextStyle.priceLarge.font,
            textColor: UIColor(color: .base0)
        )
        
        nameLabel = ViewFactory.shared.setUpLabel(
            label: nameLabel,
            text: "Futuristic Holographic Soccer Cleats",
            font: TextStyle.productTitle.font,
            textColor: UIColor(color: .base5)
        )
        
        descriptionLabel = ViewFactory.shared.setUpLabel(
            label: descriptionLabel,
            text: "Step onto the field and stand out from the crowd with these eye-catching holographic soccer cleats. Designed for the modern player, these cleats feature...",
            font: TextStyle.body.font,
            textColor: UIColor(color: .description)
        )
        
        priceLabel.numberOfLines = Constant.Labels.pricenumberOfLines
        nameLabel.numberOfLines = Constant.Labels.nameNumberOfLines
        descriptionLabel.numberOfLines = Constant.Labels.descriptionNumberOfLines
        
        [priceLabel, nameLabel, descriptionLabel].forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setUpCategoryView() {
        let wrap: UIView = UIView()
        wrap.backgroundColor = UIColor(color: .base50)
        wrap.layer.cornerRadius = Constant.CategoryView.cornerRadius
        
        categoryLabel = ViewFactory.shared.setUpLabel(
            label: categoryLabel,
            text: "Shoes",
            font: TextStyle.body.font,
            textColor: UIColor(color: .base0)
        )
        
        categoryLabel.numberOfLines = Constant.CategoryView.numberOfLines
        
        wrap.addSubview(categoryLabel)
        view.addSubview(wrap)
    
        categoryLabel.pinVertical(to: wrap, Constant.CategoryView.verticalOffset)
        categoryLabel.pinHorizontal(to: wrap, Constant.CategoryView.horizontalOffset)
        stackView.addArrangedSubview(wrap)
    }
    
    private func setUpAddButton() {
        addButton = ViewFactory.shared.setUpButton(button: addButton, title: Constant.AddButton.title)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.pinTop(to: stackView.bottomAnchor, Constant.AddButton.topOffset)
        addButton.pinHorizontal(to: view, Constant.AddButton.horizontalOffset)
    }
    
    private func setUpCounter() {
        let minusButton: UIButton = UIButton()
        let plusButton: UIButton = UIButton()
        
        counter.layer.cornerRadius = Constant.Counter.cornerRadius
        counter.backgroundColor = UIColor(color: .base50)
        counter.isHidden = true
        
        minusButton.setImage(Constant.Counter.minusImage, for: .normal)
        minusButton.tintColor = UIColor(color: .base0)
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        
        plusButton.setImage(Constant.Counter.plusImage, for: .normal)
        plusButton.tintColor = UIColor(color: .base0)
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        counterLabel = ViewFactory.shared.setUpLabel(
            label: counterLabel,
            font: TextStyle.productTitle.font,
            textColor: UIColor(color: .base0),
            alignment: .center
        )
        
        [counterLabel, plusButton, minusButton].forEach { view in
            counter.addSubview(view)
            view.pinVertical(to: counter, Constant.Counter.verticalInset)
        }
        
        minusButton.pinLeft(to: counter, Constant.Counter.buttonHorizontalOffset)
        minusButton.setWidth(Constant.Counter.buttonSize)
        minusButton.setHeight(Constant.Counter.buttonSize)
        
        plusButton.pinRight(to: counter, Constant.Counter.buttonHorizontalOffset)
        plusButton.setWidth(Constant.Counter.buttonSize)
        plusButton.setHeight(Constant.Counter.buttonSize)
        
        counterLabel.pinLeft(to: minusButton.trailingAnchor, Constant.Counter.labelHorizontalOffset)
        counterLabel.pinRight(to: plusButton.leadingAnchor, Constant.Counter.labelHorizontalOffset)
        counterLabel.setWidth(Constant.Counter.labelWidth)
        counterLabel.pinCenterX(to: counter)
        
        view.addSubview(counter)
        counter.pinTop(to: stackView.bottomAnchor, Constant.Counter.topOffset)
        counter.pinLeft(to: view, Constant.Counter.leftOffset)
    }
    
    private func setUpToCartButton() {
        toCartButton = ViewFactory.shared.setUpButton(button: toCartButton, title: Constant.ToCartButton.title)
        toCartButton.addTarget(self, action: #selector(toCartButtonTapped), for: .touchUpInside)
        toCartButton.isHidden = true
        
        view.addSubview(toCartButton)
        toCartButton.pinTop(to: stackView.bottomAnchor, Constant.ToCartButton.topOffset)
        toCartButton.pinLeft(to: counter.trailingAnchor, Constant.ToCartButton.leftOffset)
        toCartButton.pinRight(to: view, Constant.ToCartButton.rightOffset)
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        interactor.goBack()
    }
    
    @objc
    private func shareButtonTapped() {
        let activityViewController: UIActivityViewController = UIActivityViewController(
            activityItems: ["test"],
            applicationActivities: nil
        )
        
        interactor.shareProduct(shareSheet: activityViewController)
    }
    
    @objc
    private func addButtonTapped() {
        counterLabel.text = "1"
        addButton.isHidden = true
        counter.isHidden = false
        toCartButton.isHidden = false
    }
    
    @objc
    private func plusButtonTapped() {
        if var number = Int(counterLabel.text ?? "0") {
            number += 1
            counterLabel.text = "\(min(number, 99))"
        }
    }
    
    @objc
    private func minusButtonTapped() {
        if var number = Int(counterLabel.text ?? "0") {
            number -= 1
            if number == 0 {
                addButton.isHidden = false
                counter.isHidden = true
                toCartButton.isHidden = true
            }
            
            counterLabel.text = "\(max(number, 0))"
        }
    }
    
    @objc
    private func toCartButtonTapped() {
        print(1)
    }
}
