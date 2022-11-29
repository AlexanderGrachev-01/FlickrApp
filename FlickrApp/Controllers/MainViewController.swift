//
//  MainViewController.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 28.11.2022.
//

import UIKit

class MainViewController: UIViewController {

    private let searchBar = UISearchBar()
    
    var photos: [Photo] = []
    
    private let segmentController: UISegmentedControl = {
        let view = UISegmentedControl()
        
        return view
    }()
    
    private let photoList: UITableView = {
        let view = UITableView(frame: .zero)
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        
        return view
    }()
    
    private let photoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addSubviews()
        setConstraints()
        PhotoDownloader().loadPhotos(completion: { photos in
            self.photos = photos ?? []
            self.photoCollection.reloadData()
            self.photoList.reloadData()
        })
    }

    private func configure() {
        title = "Flickr"
        view.backgroundColor = .white
        
        searchBar.placeholder = "Search"
        
        segmentController.isHidden = true
        
        photoList.backgroundColor = .white
        photoList.dataSource = self
        photoList.delegate = self
        
        photoCollection.isHidden = true
        photoCollection.backgroundColor = .white
        photoCollection.dataSource = self
        photoCollection.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(segmentController)
        view.addSubview(photoList)
        view.addSubview(photoCollection)
    }
}


extension MainViewController {
    
    private func setConstraints() {
        
        photoList.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 36),
            
            photoList.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            photoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            photoCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            photoCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photoCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photoCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            segmentController.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            segmentController.heightAnchor.constraint(equalToConstant: 20),
            segmentController.widthAnchor.constraint(equalToConstant: 60),
            segmentController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = photoList.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
        cell.configure(imageURL: photos[indexPath.row].imageURL, name: photos[indexPath.row].name, date: photos[indexPath.row].date, tags: photos[indexPath.row].tags)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        photoList.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(SelectedPhotoViewController(), animated: true)
    }
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoCollection.deselectItem(at: indexPath, animated: true)
        navigationController?.pushViewController(SelectedPhotoViewController(), animated: true)
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
