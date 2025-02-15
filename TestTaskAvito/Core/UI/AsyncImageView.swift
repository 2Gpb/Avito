//
//  ImageView.swift
//  TestTaskAvito
//
//  Created by Peter on 14.02.2025.
//

import UIKit

final class AsyncImageView: UIView {
    // MARK: - Constants
    private enum Constant {
        enum Error {
            static let message = "init(coder:) has not been implemented"
            static let image: UIImage? = UIImage(named: "FailedLoadImage")
        }
    }
    
    // MARK: - Private fields
    private let image: UIImageView = UIImageView()
    private let shimmer: ShimmerView = ShimmerView()
    
    // MARK: - Variablse
    private var currentLoadingURL: URL?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constant.Error.message)
    }
    
    // MARK: - Methods
    func loadImage(path: String) {
        let path = path.trimmingCharacters(in: CharacterSet(charactersIn: "[]\""))
        guard let url = URL(string: path), url != currentLoadingURL else { return }
        
        currentLoadingURL = url
        if url.scheme == "http" {
            showWarning()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil  {
                self?.showWarning()
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                self?.showWarning()
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard self?.currentLoadingURL == url else { return }
                self?.image.image = image
                self?.shimmer.isHidden = true
                self?.shimmer.stopShimmering()
            }
        }.resume()
    }
    
    func reuse() {
        currentLoadingURL = nil
        image.image = nil
        shimmer.isHidden = false
        shimmer.startShimmering()
    }
    
    func set(contentMode: ContentMode) {
        image.contentMode = contentMode
    }
    
    // MARK: - Private methods
    private func showWarning() {
        DispatchQueue.main.async { [weak self] in
            self?.image.image = Constant.Error.image
            self?.shimmer.stopShimmering()
        }
    }

    private func setUp() {
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .clear
        shimmer.startShimmering()
        
        addSubview(shimmer)
        addSubview(image)
        shimmer.pin(to: self)
        image.pin(to: self)
    }
}
