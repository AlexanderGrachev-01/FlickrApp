//
//  PhotoTableViewCell.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 28.11.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "PhotoListCell"
    
    private let photoImageView = UIImageView()
    private let name = UILabel()
    private let date = UILabel()
    private let tags = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
    }
    
    func setInfo(imageURL: String, name: String, date: String, tags: String) {
        if let url = URL(string: imageURL) {
            DispatchQueue.global(qos: .utility).async {
                let image = (try? Data(contentsOf: url))
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: image!)
                }
            }
        }
        self.name.font = .systemFont(ofSize: 22)
        self.name.text = name
        self.date.font = .systemFont(ofSize: 14)
        var dayOnly = date
        dayOnly.removeLast(15)
        self.date.text = dayOnly
        self.tags.font = .systemFont(ofSize: 18)
        self.tags.numberOfLines = 5
        self.tags.text = tags
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        date.text = nil
        tags.text = nil
    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(name)
        addSubview(date)
        addSubview(tags)
    }
}

extension PhotoTableViewCell {
    
    private func setConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        tags.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 200),
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            date.topAnchor.constraint(equalTo: name.bottomAnchor),
            date.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            date.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tags.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 16),
            tags.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            tags.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
