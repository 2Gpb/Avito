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
            static let placeholder: String = "Search"
            static let topOffset: CGFloat = 8
            static let horizontalOffset: CGFloat = 16
            static let leftViewWidth: CGFloat = 40
            static let leftViewHeight: CGFloat = 16
            static let leftViewImageOffset: CGRect = CGRect(x: 18, y: 0, width: 17, height: 16)
            static let leftImage: UIImage? = UIImage(
                systemName: "magnifyingglass",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .small)
            )
            
            static let rightViewWidth: CGFloat = 40
            static let rightViewHeight: CGFloat = 20
            static let rightImage: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold, scale: .small)
            )
            static let clearButtonFrame: CGRect = CGRect(x: 10, y: 0, width: 20, height: 20)
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
        
        enum CancelButton {
            static let title: String = "Cancel"
            static let backgroundColor: UIColor = .clear
            static let topOffset: CGFloat = 8
            static let rightOffset: CGFloat = 16
            static let width: CGFloat = 70
        }
        
        enum Table {
            static let topOffset: CGFloat = 12
            static let heightCell: CGFloat = 55
        }
    }
    // MARK: - Private fields
    private var interactor: SearchBusinessLogic
    
    // MARK: - UI Components
    private var cancelButton: UIButton = UIButton(type: .system)
    private let searchHistoryTable: UITableView = UITableView()
    private var searchTextField: UITextField = UITextField()
    private var searchTextFieldRightConstarint: NSLayoutConstraint?
    private let clearSearchTextFieldButton: UIButton = UIButton(type: .system)
    private let leftViewSearchTextField: UIImageView = UIImageView()
    private let rightViewSearchTextField: UIImageView = UIImageView()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadStart()
    }
    
    // MARK: - Methods
    func displayStart() {
        collection.reloadData()
    }
    
    func displayFilters() {
        collection.reloadSections(IndexSet(integer: 0))
    }
    
    func displayCategoryName(_ name: String) {
        title = name
    }
    
    // MARK: - SetUp
    private func setUp() {
        view.backgroundColor = UIColor(color: .base80)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setUpSearchTextField()
        setUpProductCollection()
        
        setUpCancelButton()
        setUpSearchHistoryTable()
    }
    
    private func setUpSearchTextField() {
        leftViewSearchTextField.image = Constant.SearchTextField.leftImage
        leftViewSearchTextField.tintColor = UIColor(color: .base10)
        searchTextField = ViewFactory.shared.setUpTextField(
            textField: searchTextField,
            placeholder: Constant.SearchTextField.placeholder,
            leftView: setUpLeftViewForTextField(
                imageView: leftViewSearchTextField,
                width: Constant.SearchTextField.leftViewWidth,
                height: Constant.SearchTextField.leftViewHeight,
                offset: Constant.SearchTextField.leftViewImageOffset
            ),
            rightView: setUpRightViewForTextField(
                imageView: Constant.SearchTextField.rightImage,
                width: Constant.SearchTextField.rightViewWidth,
                height: Constant.SearchTextField.rightViewHeight
            )
        )
        
        clearSearchTextFieldButton.isHidden = true
        searchTextField.delegate = self
        searchTextField.keyboardType = .default
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openSearch))
        searchTextField.addGestureRecognizer(gesture)
        
        view.addSubview(searchTextField)
        searchTextField.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.SearchTextField.topOffset)
        searchTextField.pinLeft(to: view, Constant.SearchTextField.horizontalOffset)
        searchTextFieldRightConstarint = searchTextField.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -Constant.SearchTextField.horizontalOffset
        )

        searchTextFieldRightConstarint?.isActive = true
    }
    
    private func setUpLeftViewForTextField(
        imageView: UIImageView,
        width: CGFloat,
        height: CGFloat,
        offset: CGRect
    ) -> UIView {
        let leftView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftView.addSubview(imageView)
        imageView.frame = offset
        return leftView
    }
    
    private func setUpRightViewForTextField(
        imageView: UIImage?,
        width: CGFloat,
        height: CGFloat
    ) -> UIView {
        let rightView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        clearSearchTextFieldButton.setImage(imageView, for: .normal)
        clearSearchTextFieldButton.tintColor = UIColor(color: .base0)
        clearSearchTextFieldButton.addTarget(
                self,
                action: #selector(clearSearchTextField),
                for: .touchUpInside
            )
        
        rightView.addSubview(clearSearchTextFieldButton)
        clearSearchTextFieldButton.frame = Constant.SearchTextField.clearButtonFrame
        return rightView
    }
    
    private func setUpProductCollection() {
        collection.delegate = self
        collection.dataSource = interactor
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
    
    private func setUpCancelButton() {
        cancelButton = ViewFactory.shared.setUpButton(
            button: cancelButton,
            title: Constant.CancelButton.title,
            font: TextStyle.bodySmallMedium.font,
            titleColor: UIColor(color: .lightBlue),
            backgroundColor: Constant.CancelButton.backgroundColor
        )
        
        cancelButton.isHidden = true
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        view.addSubview(cancelButton)
        cancelButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constant.CancelButton.topOffset)
        cancelButton.pinRight(to: view, Constant.CancelButton.rightOffset)
        cancelButton.setWidth(Constant.CancelButton.width)
    }
    
    private func setUpSearchHistoryTable() {
        searchHistoryTable.delegate = self
        searchHistoryTable.dataSource = self
        searchHistoryTable.backgroundColor = UIColor(color: .base70)
        searchHistoryTable.isHidden = true
        searchHistoryTable.separatorStyle = .none
        searchHistoryTable.register(SearchQueryCell.self, forCellReuseIdentifier: SearchQueryCell.reuseId)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        searchHistoryTable.addGestureRecognizer(tapGesture)
        
        view.addSubview(searchHistoryTable)
        searchHistoryTable.pinTop(to: searchTextField.bottomAnchor, Constant.Table.topOffset)
        searchHistoryTable.pinHorizontal(to: view)
        searchHistoryTable.pinBottom(to: view)
    }
    
    // MARK: - Actions
    @objc
    private func openSearch() {
        view.backgroundColor = UIColor(color: .base70)
        searchTextField.becomeFirstResponder()
        
        if searchTextField.text != "" && searchTextField.text != nil {
            clearSearchTextFieldButton.isHidden = false
        }
    
        searchTextFieldRightConstarint?.isActive = false
        searchTextFieldRightConstarint = searchTextField.trailingAnchor.constraint(
            equalTo: cancelButton.leadingAnchor,
            constant: -8
        )
        
        searchTextFieldRightConstarint?.isActive = true
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.cancelButton.isHidden = false
        })
        
        collection.isHidden = true
        searchHistoryTable.isHidden = false
    }
    
    @objc
    private func cancelButtonTapped() {
        view.backgroundColor = UIColor(color: .base80)
        searchTextField.resignFirstResponder()
        searchTextField.text = nil
        leftViewSearchTextField.tintColor = UIColor(color: .base10)
        
        searchTextFieldRightConstarint?.isActive = false
        searchTextFieldRightConstarint = searchTextField.trailingAnchor
            .constraint(
                equalTo: view.trailingAnchor,
                constant: -Constant.SearchTextField.horizontalOffset
            )
        
        searchTextFieldRightConstarint?.isActive = true

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        
        clearSearchTextFieldButton.isHidden = true
        cancelButton.isHidden = true
        searchHistoryTable.isHidden = true
        collection.isHidden = false
    }
    
    @objc
    private func dismissKeyboard() {
        clearSearchTextFieldButton.isHidden = true
        searchTextField.resignFirstResponder()
    }
    
    @objc
    private func clearSearchTextField() {
        searchTextField.text = nil
        leftViewSearchTextField.tintColor = UIColor(color: .base10)
        clearSearchTextFieldButton.isHidden = true
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        clearSearchTextFieldButton.isHidden = false
        leftViewSearchTextField.tintColor = UIColor(color: .base0)
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        if newText.isEmpty {
            leftViewSearchTextField.tintColor = UIColor(color: .base10)
            clearSearchTextFieldButton.isHidden = true
        }
        
        return true
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.loadProductCard(for: indexPath.row)
    }
    
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

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constant.Table.heightCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        clearSearchTextFieldButton.isHidden = true
        searchTextField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchHistoryTable.dequeueReusableCell(
            withIdentifier: SearchQueryCell.reuseId
        ) as? SearchQueryCell else {
            return UITableViewCell()
        }
        
        cell.configure(query: "Sandals")
        return cell
    }
}
