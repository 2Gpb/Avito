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
            static let height: CGFloat = 24
        }
    }
    
    // MARK: - Private fields
    private let interactor: ProductCardBusinessLogic
    
    // MARK: - UI Components
    private let backButton: UIButton = UIButton(type: .system)
    private let shareButton: UIButton = UIButton(type: .system)
    
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
}
