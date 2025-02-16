//
//  ShopingListViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class ShoppingListViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum Title {
            static let text = "Shopping list"
            static let topOffset: CGFloat = 14
        }
        
        enum ShareButton {
            static let image: UIImage? = UIImage(
                systemName: "square.and.arrow.up",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .semibold,
                    scale: .default
                )
            )
            
            static let topOffset: CGFloat = 4
            static let rightOffset: CGFloat = 6
            static let size: CGFloat = 44
        }
        
        enum ClearButton {
            static let title: String = "Clear all"
            static let leftoffset: CGFloat = 16
            static let bottomOffset: CGFloat = 16
            static let emptySpace: CGFloat = 44
        }
        
        enum BuyButton {
            static let title: String = "Buy"
            static let rightoffset: CGFloat = 16
            static let bottomOffset: CGFloat = 16
            static let emptySpace: CGFloat = 44
        }
        
        enum CollectionView {
            static let topOffset: CGFloat = 14
            static let cellHeight: CGFloat = 96
            static let cellOffsets: CGFloat = 32
            static let lineSpacing: CGFloat = 20
            static let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
        
        enum Alert {
            static let title: String = "Do you want to delete this product?"
            static let cancelTitle: String = "Cancel"
            static let deleteTitle: String = "Delete"
        }
        
        enum EmptyStateView {
            static let image: UIImage? = UIImage(systemName: "bookmark.slash.fill")
            static let title: String = "Your shopping list is empty"
            static let description: String = "Add some products to your list"
        }
    }
    
    // MARK: - Private fields
    private let interactor: ShoppingListBusinessLogic
    
    //MARK: - UI Components
    private var titleLabel: UILabel = UILabel()
    private let shareButton: UIButton = UIButton(type: .system)
    private var buyButton: UIButton = UIButton(type: .system)
    private var clearButton: UIButton = UIButton(type: .system)
    private let alert: UIAlertController = UIAlertController()
    private let emptyStateView: StateView = StateView(
        image: Constant.EmptyStateView.image,
        title: Constant.EmptyStateView.title,
        description: Constant.EmptyStateView.description
    )
    
    private let collection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    init(interactor: ShoppingListBusinessLogic) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayStart(emptyState: Bool) {
        collection.reloadData()
        emptyStateView.isHidden = !emptyState
    }
    
    func setUpAlert(id: Int) -> UIAlertController {
        let alert = UIAlertController(
            title: Constant.Alert.title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let cancelAction = UIAlertAction(
            title: Constant.Alert.cancelTitle,
            style: .cancel,
            handler: nil
        )
        
        let deleteAction = UIAlertAction(
            title: Constant.Alert.deleteTitle,
            style: .destructive,
            handler: { [weak self] _ in
            self?.interactor.deleteProduct(at: id)
        })
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        return alert
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = UIColor(color: .base70)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setUpTitle()
        setUpShareButton()
        setUpCollection()
        setUpClearButton()
        setUpBuyButton()
        setUpEmptyStateView()
    }
    
    private func setUpTitle() {
        titleLabel = ViewFactory.shared.setUpLabel(
            label: titleLabel,
            text: Constant.Title.text,
            font: TextStyle.titleLarge.font,
            textColor: UIColor(color: .base0)
        )
        
        view.addSubview(titleLabel)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.Title.topOffset)
        titleLabel.pinCenterX(to: view)
    }
    
    private func setUpShareButton() {
        shareButton.setImage(Constant.ShareButton.image, for: .normal)
        shareButton.tintColor = UIColor(color: .base0)
        shareButton.backgroundColor = .clear
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
        view.addSubview(shareButton)
        shareButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.ShareButton.topOffset)
        shareButton.pinRight(to: view, Constant.ShareButton.rightOffset)
        shareButton.setWidth(Constant.ShareButton.size)
        shareButton.setHeight(Constant.ShareButton.size)
    }
    
    private func setUpCollection() {
        collection.delegate = self
        collection.dataSource = interactor
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.register(ShoppingListCell.self, forCellWithReuseIdentifier: ShoppingListCell.reuseId)
        
        view.addSubview(collection)
        collection.pinTop(to: titleLabel.bottomAnchor, Constant.CollectionView.topOffset)
        collection.pinHorizontal(to: view)
        collection.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func setUpEmptyStateView() {
        emptyStateView.isHidden = true
        
        view.addSubview(emptyStateView)
        emptyStateView.pinTop(to: titleLabel.bottomAnchor, Constant.CollectionView.topOffset)
        emptyStateView.pinHorizontal(to: view)
        emptyStateView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func setUpClearButton() {
        clearButton = ViewFactory.shared.setUpButton(
            button: clearButton,
            title: Constant.ClearButton.title,
            titleColor: UIColor(color: .base0),
            backgroundColor: UIColor(color: .base50)
        )
        
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        view.addSubview(clearButton)
        clearButton.pinLeft(to: view, Constant.ClearButton.leftoffset)
        clearButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constant.ClearButton.bottomOffset)
        clearButton.setWidth((view.frame.width - Constant.ClearButton.emptySpace) / CGFloat(2))
    }
    
    private func setUpBuyButton() {
        buyButton = ViewFactory.shared.setUpButton(
            button: buyButton,
            title: Constant.BuyButton.title
        )
        
        view.addSubview(buyButton)
        buyButton.pinRight(to: view, Constant.BuyButton.rightoffset)
        buyButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constant.BuyButton.bottomOffset)
        buyButton.setWidth((view.frame.width - Constant.BuyButton.emptySpace) / CGFloat(2))
    }
    
    // MARK: - Actions
    @objc
    private func shareButtonTapped() {        
        interactor.shareCart()
    }
    
    @objc private func clearButtonTapped() {
        interactor.clearCart()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShoppingListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        interactor.loadProductCard(for: indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: view.frame.width - Constant.CollectionView.cellOffsets,
            height: Constant.CollectionView.cellHeight
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constant.CollectionView.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constant.CollectionView.edgeInsets
    }
}
