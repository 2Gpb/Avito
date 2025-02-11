//
//  ViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 10.02.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    private var interactor: SearchBusinessLogic
    
    init(interactor: SearchBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadStart()
    }
    
    func displayStart() {
        view.backgroundColor = UIColor(color: .base80)
        let factory = MainViewFactory()
        let title = factory.createLabel(
            text: "39$",
            font: TextStyle.priceLarge.font,
            textColor: UIColor(color: .base0)
        )
        
        view.addSubview(title)
        title.pinCenter(to: view)
    }
}
