//
//  CategoryViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 12.02.2025.
//

import UIKit

final class CategoryViewController: UIViewController {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
        }
        
        enum Sheet {
            static let cornerRadius: CGFloat = 16
        }
        
        enum WrapView {
            static let height: CGFloat = 68
        }
        
        enum Title {
            static let text = "Categories"
            static let bottomOffset: CGFloat = 17
        }
        
        enum CloseButton {
            static let bottomOffset: CGFloat = 17
            static let leftOffset: CGFloat = 16
            static let width: CGFloat = 20
            static let height: CGFloat = 19
            static let image: UIImage? = UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
            )
        }
        
        enum TableView {
            static let heightForRow: CGFloat = 48
        }
    }
    
    // MARK: - Private fields
    private let interactor: CategoryBusinessLogic
    
    // MARK: - UI Components
    private let wrapView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private let closeButton: UIButton = UIButton(type: .system)
    private let categoriesTableView: UITableView = UITableView()
    
    // MARK: - Lifecycle
    init(interactor: CategoryBusinessLogic) {
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
        view.backgroundColor = UIColor(color: .base70)
        setupSheetStyle()
        setUpWrapView()
        setUpTitleLabel()
        setUpCloseButton()
        setUpCategoriesTableView()
    }
    
    private func setupSheetStyle() {
        if let sheet = sheetPresentationController {
            sheet.detents = [.custom(resolver: { context in return 260 })]
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
        titleLabel.pinBottom(to: wrapView.bottomAnchor, Constant.Title.bottomOffset)
        titleLabel.pinCenterX(to: wrapView)
    }
    
    private func setUpCloseButton() {
        closeButton.setImage(
            Constant.CloseButton.image,
            for: .normal
        )
        
        closeButton.tintColor = UIColor(color: .base0)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        wrapView.addSubview(closeButton)
        closeButton.pinBottom(to: wrapView.bottomAnchor, Constant.CloseButton.bottomOffset)
        closeButton.pinLeft(to: wrapView, Constant.CloseButton.leftOffset)
        closeButton.setWidth(Constant.CloseButton.width)
        closeButton.setHeight(Constant.CloseButton.height)
    }
    
    private func setUpCategoriesTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.backgroundColor = UIColor(color: .base80)
        categoriesTableView.separatorStyle = .none
        categoriesTableView.isScrollEnabled = false
        categoriesTableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        
        view.addSubview(categoriesTableView)
        categoriesTableView.pinTop(to: wrapView.bottomAnchor)
        categoriesTableView.pinHorizontal(to: view)
        categoriesTableView.pinBottom(to: view)
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        interactor.closeScreen()
    }
}

// MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.TableView.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoryCell else {
            return
        }
        
        cell.showCheckImage()
        interactor.closeScreen()
    }
}

// MARK: - UITableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoryCell.reuseId
        ) as? CategoryCell else {
            return UITableViewCell()
        }
        
        cell.configure(text: "Electronics")
        return cell
    }
}
