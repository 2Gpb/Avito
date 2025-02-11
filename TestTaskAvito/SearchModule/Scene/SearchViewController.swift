//
//  ViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 10.02.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum SearchTextField {
            static let leftImage: UIImage? = UIImage(systemName: "magnifyingglass")
            static let placeholder: String = "Search"
            static let topOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 16
            static let leftViewWidth: CGFloat = 48
            static let leftViewHeight: CGFloat = 20
            static let leftViewRightOffset: CGFloat = 8
        }
        
        enum Collection {
            static let topOffset: CGFloat = 12
            static let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            static let lineSpacing: CGFloat = 8
            static let interitemSpacing: CGFloat = 12
            static let filtersHeight: CGFloat = 108
            static let productsHeight: CGFloat = 262
            static let filterEmptySpacing: CGFloat = 32
            static let productEmptySpacing: CGFloat = 44
        }
    }
    
    private enum CollectionSection: Int, CaseIterable {
        case filters
        case products
    }
    
    // MARK: - Private fields
    private var interactor: SearchBusinessLogic
    
    // MARK: - UI Components
    private let factory: ViewFactory = ViewFactory()
    private var searchTextField: UITextField = UITextField()
    private var searchTextFieldRightConstarint: NSLayoutConstraint?
    private let searchTextFieldLeftView: UIImageView = UIImageView()
    private let collection: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    init(interactor: SearchBusinessLogic) {
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
    func displayStart() { }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = UIColor(color: .base80)
        
        setUpSearchTextField()
        setUpProductCollection()
    }
    
    private func setUpSearchTextField() {
        searchTextFieldLeftView.image = Constant.SearchTextField.leftImage
        searchTextFieldLeftView.tintColor = UIColor(color: .base10)
        searchTextField = factory.setUpTextField(
            textField: searchTextField,
            placeholder: Constant.SearchTextField.placeholder,
            leftView: factory.setUpViewForTextField(
                imageView: searchTextFieldLeftView,
                width: Constant.SearchTextField.leftViewWidth,
                height: Constant.SearchTextField.leftViewHeight,
                rightOffset: Constant.SearchTextField.leftViewRightOffset
            )
        )
        
        searchTextField.delegate = self
        
        view.addSubview(searchTextField)
        searchTextField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.SearchTextField.topOffset)
        searchTextField.pinLeft(to: view, Constant.SearchTextField.horizontalOffset)
        searchTextFieldRightConstarint = searchTextField.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -Constant.SearchTextField.horizontalOffset
        )

        searchTextFieldRightConstarint?.isActive = true
    }
    
    private func setUpProductCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor(color: .base70)
        collection.register(
            ProductViewCell.self,
            forCellWithReuseIdentifier: ProductViewCell.reuseId
        )
        
        collection.register(
            FiltersViewCell.self,
            forCellWithReuseIdentifier: FiltersViewCell.reuseId
        )
        
        view.addSubview(collection)
        collection.pinTop(to: searchTextField.bottomAnchor, Constant.Collection.topOffset)
        collection.pinHorizontal(to: view)
        collection.pinBottom(to: view)
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let section = CollectionSection.allCases[indexPath.section]
        
        switch section {
        case .filters:
            return CGSize(
                width: view.frame.width - Constant.Collection.filterEmptySpacing,
                height: Constant.Collection.filtersHeight
            )
        case .products:
            return CGSize(
                width: (view.frame.width - Constant.Collection.productEmptySpacing) / 2,
                height: Constant.Collection.productsHeight
            )
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constant.Collection.sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constant.Collection.interitemSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        let section = CollectionSection.allCases[section]
        
        switch section {
        case .filters:
            return 0
        case .products:
            return Constant.Collection.lineSpacing
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CollectionSection.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let section = CollectionSection.allCases[section]
        
        switch section {
        case .filters:
            return 1
        case .products:
            return 8
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let section = CollectionSection.allCases[indexPath.section]
        
        switch section {
        case .filters:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FiltersViewCell.reuseId,
                for: indexPath
            ) as? FiltersViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        case .products:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductViewCell.reuseId,
                for: indexPath
            ) as? ProductViewCell else {
                return UICollectionViewCell()
            }
        
            cell.configure(name: "Futuristic Holographic Soccer Cleats", price: "39$")
            return cell
        }
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        guard let rightConstraint = searchTextFieldRightConstarint else { return }
        rightConstraint.constant = -50
        view.layoutIfNeeded()
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        searchTextFieldLeftView.tintColor = UIColor(color: .base0)
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if newText.isEmpty {
            searchTextFieldLeftView.tintColor = UIColor(color: .base10)
        }
        
        return true
    }
}
