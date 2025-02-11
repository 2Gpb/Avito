//
//  ProductCollectionViewCell.swift
//  TestTaskAvito
//
//  Created by Peter on 11.02.2025.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - ReuseID
    static let reuseId = "ProductCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
}
