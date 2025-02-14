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
            static let topOffset: CGFloat = 4
            static let leftOffset: CGFloat = 5
            static let width: CGFloat = 44
            static let height: CGFloat = 44
            static let image: UIImage? = UIImage(
                systemName: "chevron.left",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .regular,
                    scale: .default
                )
            )
        }
        
        enum ShareButton {
            static let topOffset: CGFloat = 4
            static let rightOffset: CGFloat = 5
            static let width: CGFloat = 44
            static let height: CGFloat = 44
            static let image: UIImage? = UIImage(
                systemName: "square.and.arrow.up",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .regular,
                    scale: .default
                )
            )
        }
        
        enum ProductImageView {
            static let topOffset: CGFloat = 4
            static let heightDivider: CGFloat = 1.55
        }
        
        enum Stack {
            static let spacingCoeff: CGFloat = 0.014
            static let topOffset: CGFloat = 16
            static let horizontalOffset: CGFloat = 16
        }
        
        enum Labels {
            static let pricenumberOfLines: Int = 1
            static let nameNumberOfLines: Int = 2
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
            static let topOffsetCoeff: CGFloat = 0.022
            static let horizontalOffset: CGFloat = 16
        }
         
        enum Counter {
            static let topOffsetCoeff: CGFloat = 0.022
            static let leftOffset: CGFloat = 16
            static let verticalInset: CGFloat = 2
            static let horizontalInset: CGFloat = 2
            static let buttonSize: CGFloat = 44
        }
        
        enum ToCartButton {
            static let title: String = "To the shopping list"
            static let topOffsetCoeff: CGFloat = 0.022
            static let leftOffset: CGFloat = 12
            static let rightOffset: CGFloat = 16
        }
    }
    
    // MARK: - Private fields
    private let interactor: ProductCardBusinessLogic
    
    // MARK: - UI Components
    private let backButton: UIButton = UIButton(type: .system)
    private let shareButton: UIButton = UIButton(type: .system)
    private let productImageView: AsyncImageView = AsyncImageView()
    private var priceLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private let categoryWrap: UIView = UIView()
    private var categoryLabel: UILabel = UILabel()
    private let stackView: UIStackView = UIStackView()
    private var addButton: UIButton = UIButton(type: .system)
    private var counterLabel: UILabel = UILabel()
    private var toCartButton: UIButton = UIButton(type: .system)
    private var counter: UIView = UIView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayStart(model: ProductCardModel) {
        priceLabel.text = model.price
        nameLabel.text = model.title
        descriptionLabel.text = model.description
        categoryLabel.text = model.category
        productImageView.loadImage(path: model.imageAddress)
        categoryWrap.isHidden = false
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
        productImageView.backgroundColor = UIColor(color: .base10)
        productImageView.clipsToBounds = true
        productImageView.set(contentMode: .scaleAspectFit)
        
        view.addSubview(productImageView)
        productImageView.pinTop(to: backButton.bottomAnchor, Constant.ProductImageView.topOffset)
        productImageView.pinHorizontal(to: view)
        productImageView.setHeight(view.frame.width / Constant.ProductImageView.heightDivider)
    }
    
    private func setUpInfoStack() {
        stackView.axis = .vertical
        stackView.spacing = Constant.Stack.spacingCoeff * view.frame.height
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        stackView.pinTop(to: productImageView.bottomAnchor, Constant.Stack.topOffset)
        stackView.pinHorizontal(to: view, Constant.Stack.horizontalOffset)
    }
    
    private func setUpInfoLabels() {
        priceLabel = ViewFactory.shared.setUpLabel(
            label: priceLabel,
            font: TextStyle.priceLarge.font,
            textColor: UIColor(color: .base0)
        )
        
        nameLabel = ViewFactory.shared.setUpLabel(
            label: nameLabel,
            font: TextStyle.productTitle.font,
            textColor: UIColor(color: .base5)
        )
        
        descriptionLabel = ViewFactory.shared.setUpLabel(
            label: descriptionLabel,
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
        categoryWrap.backgroundColor = UIColor(color: .base50)
        categoryWrap.layer.cornerRadius = Constant.CategoryView.cornerRadius
        
        categoryLabel = ViewFactory.shared.setUpLabel(
            label: categoryLabel,
            font: TextStyle.body.font,
            textColor: UIColor(color: .base0)
        )
        
        categoryWrap.isHidden = true
        categoryLabel.numberOfLines = Constant.CategoryView.numberOfLines
        
        categoryWrap.addSubview(categoryLabel)
        view.addSubview(categoryWrap)
    
        categoryLabel.pinVertical(to: categoryWrap, Constant.CategoryView.verticalOffset)
        categoryLabel.pinHorizontal(to: categoryWrap, Constant.CategoryView.horizontalOffset)
        stackView.addArrangedSubview(categoryWrap)
    }
    
    private func setUpAddButton() {
        addButton = ViewFactory.shared.setUpButton(button: addButton, title: Constant.AddButton.title)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.pinTop(to: stackView.bottomAnchor, Constant.AddButton.topOffsetCoeff * view.frame.height)
        addButton.pinHorizontal(to: view, Constant.AddButton.horizontalOffset)
    }
    
    private func setUpCounter() {
        counterLabel = ViewFactory.shared.setUpLabel(
            label: counterLabel,
            font: TextStyle.productTitle.font,
            textColor: UIColor(color: .base0),
            alignment: .center
        )
        
        counter.isHidden = true
        counter = ViewFactory.shared.setUpCounter(
            counter: counter,
            counterLabel: counterLabel,
            target: self,
            minusButtonTapped: #selector(minusCount),
            plusButtonTapped: #selector(plusCount),
            verticalInsets: Constant.Counter.verticalInset,
            horizontalInsets: Constant.Counter.horizontalInset,
            buttonSize: Constant.Counter.buttonSize,
            buttonImageScale: .default
        )
        
        view.addSubview(counter)
        counter.pinTop(to: stackView.bottomAnchor, view.frame.height * Constant.Counter.topOffsetCoeff)
        counter.pinLeft(to: view, Constant.Counter.leftOffset)
    }
    
    private func setUpToCartButton() {
        toCartButton = ViewFactory.shared.setUpButton(button: toCartButton, title: Constant.ToCartButton.title)
        toCartButton.addTarget(self, action: #selector(toCartButtonTapped), for: .touchUpInside)
        toCartButton.isHidden = true
        
        view.addSubview(toCartButton)
        toCartButton.pinTop(to: stackView.bottomAnchor, view.frame.height * Constant.ToCartButton.topOffsetCoeff)
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
            activityItems: [nameLabel.text ?? "Product name", descriptionLabel.text ?? "Product description"],
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
    private func plusCount() {
        if var number = Int(counterLabel.text ?? "0") {
            number += 1
            counterLabel.text = "\(min(number, 99))"
        }
    }
    
    @objc
    private func minusCount() {
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
        tabBarController?.selectedIndex = 1
    }
}
