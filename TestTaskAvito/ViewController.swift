//
//  ViewController.swift
//  TestTaskAvito
//
//  Created by Peter on 10.02.2025.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
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
