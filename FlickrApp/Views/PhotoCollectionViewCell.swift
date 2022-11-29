//
//  PhotoCollectionViewCell.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 28.11.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setImageURL(imageURL: String) {
        if let url = URL(string: imageURL) {
            DispatchQueue.global(qos: .utility).async {
                let image = (try? Data(contentsOf: url))
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image!)
                }
            }
        }
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

