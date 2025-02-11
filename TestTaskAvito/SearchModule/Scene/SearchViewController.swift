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
        
        enum TextField {
            static let leftImage: UIImage? = UIImage(systemName: "magnifyingglass")
            static let placeholder: String = "Search"
            static let horizontalOffset: CGFloat = 16
        }
        
        enum ProductCollection {
            static let topOffset: CGFloat = 12
        }
    }
    
    // MARK: - Private fields
    private var interactor: SearchBusinessLogic
    
    // MARK: - UI Components
    private let factory: ViewFactory = ViewFactory()
    private var searchTextField: UITextField = UITextField()
    private let searchTextFieldLeftView: UIImageView = UIImageView()
    private let productCollectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
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
        searchTextFieldLeftView.image = Constant.TextField.leftImage
        searchTextField.delegate = self
        searchTextField = factory.createTextField(
            placeholder: Constant.TextField.placeholder,
            leftImageView: searchTextFieldLeftView
        )

        view.addSubview(searchTextField)
        searchTextField.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        searchTextField.pinHorizontal(to: view, Constant.TextField.horizontalOffset)
    }
    
    private func setUpProductCollection() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.backgroundColor = UIColor(color: .base70)
        productCollectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId
        )
        
        view.addSubview(productCollectionView)
        productCollectionView.pinTop(to: searchTextField.bottomAnchor, Constant.ProductCollection.topOffset)
        productCollectionView.pinHorizontal(to: view)
        productCollectionView.pinBottom(to: view)
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProductCollectionViewCell.reuseId,
            for: indexPath
        ) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(1)
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
