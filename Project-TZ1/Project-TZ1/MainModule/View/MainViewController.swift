//
//  ViewController.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10
//        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 120, height: 120)
//        collectionView.collectionViewLayout = layout
        
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
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        guard let photos = presenter.photos?[indexPath.item].large_url else { return cell }
        cell.photoView.contentMode = .scaleAspectFill
        cell.photoView.clipsToBounds = true
        cell.photoView.image = nil
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.configure(with: photos)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return CGSize(width: 120, height: 120)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photo = presenter.photos?[indexPath.item] else { return }
        let detailViewController = ModuleBuilder.createDetailModule(photo: photo)
//        navigationController?.pushViewController(detailViewController, animated: true)
        self.present(detailViewController, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewProtocol {
    func succes() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        showAlert(message: error.localizedDescription)
    }
}

