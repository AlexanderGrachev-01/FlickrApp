//
//  SelectedPhotoViewController.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 28.11.2022.
//

import UIKit

class SelectedPhotoViewController: UIViewController {
    
    private let imageView = UIImageView()
    private var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addSubviwes()
        setConstraints()
    }
    
    private func configure() {
        imageView.contentMode = .scaleAspectFit
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
    
    private func addSubviwes() {
        view.addSubview(imageView)
    }
}

extension SelectedPhotoViewController {
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
