//
//  MainTabBarController.swift
//  TestTaskAvito
//
//  Created by Peter on 13.02.2025.
//

import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - Constants
    private enum Constant {
        enum Search {
            static let title: String = "Search"
            static let imageName: String = "square.grid.2x2.fill"
            static let tag: Int = 1
        }
        
        enum Cart {
            static let title: String = "Shopping list"
            static let imageName: String = "cart.fill"
            static let tag: Int = 2
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - SetUp
    private func setUp() {
        setUpAppearance()
        setUpControllers()
    }
    
    private func setUpAppearance() {
        tabBar.backgroundColor = UIColor(color: .base60)
        tabBar.tintColor = UIColor(color: .lightBlue)
        tabBar.unselectedItemTintColor = UIColor(color: .base20)
        tabBar.isTranslucent = false
        
        UITabBarItem
            .appearance()
            .setTitleTextAttributes([.font: TextStyle.tabSmall.font],for: .normal)
    }
    
    private func setUpControllers() {
        let searchViewController = createNavController(
            rootViewController: SearchAssembly.build(),
            title: Constant.Search.title,
            imageName: Constant.Search.imageName,
            tag: Constant.Search.tag
        )
        
        let shoppingListViewController = createNavController(
            rootViewController: ShoppingListAssembly.build(),
            title: Constant.Cart.title,
            imageName: Constant.Cart.imageName,
            tag: Constant.Cart.tag
        )
        
        setViewControllers([searchViewController, shoppingListViewController], animated: false)
    }
    
    func createNavController(
        rootViewController: UIViewController,
        title: String,
        imageName: String,
        tag: Int
    ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName),
            tag: tag
        )
        
        return navController
    }
}
