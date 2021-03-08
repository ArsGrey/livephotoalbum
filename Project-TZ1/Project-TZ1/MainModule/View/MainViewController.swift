//
//  ViewController.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MainViewProtocol {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MainViewPresenterProtocol!
    var collectionData: [Data] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
        presenter.getPhotos()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: -> UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let data = collectionData[indexPath.item]
        cell.photoView.contentMode = .scaleAspectFill
        cell.photoView.clipsToBounds = true
        cell.photoView.image = nil
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.set(data: data)
        return cell
    }
    
    //MARK: -> UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = presenter.photos[indexPath.item]
        let detailViewController = ModuleBuilder.createDetailModule(photo: photo)
        self.present(detailViewController, animated: true, completion: nil)
    }
    
    //MARK: -> UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    //MARK: -> MainViewProtocol
    func showCollection(data: [Data]) {
        collectionData = data
        collectionView.reloadData()
        loader.stopAnimating()
        loader.isHidden = true
    }
    
    func showError(error: Error) {
        showAlert(message: error.localizedDescription)
        loader.stopAnimating()
        loader.isHidden = true
    }
}
