//
//  DetailViewController.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 01.02.2021.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController, DetailViewProtocol {
    
    @IBOutlet private weak var mediaView: UIView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    var presenter: DetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSpinner()
        presenter.fetchMedia()
    }
    
    func set(photo: Photos) {
        presenter.photo = photo
    }
    
    func test(livePhoto: PHLivePhoto?) {
        guard let livePhoto = livePhoto else {
            let emptyView = UIImageView(frame: self.mediaView.frame)
            emptyView.image = UIImage(named: "empty")
            mediaView.addSubview(emptyView)
            return
        }
        let livePhotoView = PHLivePhotoView(frame: mediaView.frame)
        livePhotoView.livePhoto = livePhoto
        mediaView.addSubview(livePhotoView)
    }
    
    func showMedia() {
        guard let filePhotoUrl = presenter.filePhotoUrl,
              let fileMovieUrl = presenter.fileMovieUrl,
              let data = try? Data(contentsOf: filePhotoUrl),
              let photo = UIImage(data: data) else {
            stopSpinner()
            test(livePhoto: nil)
            return
        }
        
        makeLivePhoto(imageUrl: filePhotoUrl,
                      movieUrl: fileMovieUrl,
                      previewImage: photo) { [weak self] livePhoto in
            self?.test(livePhoto: livePhoto)
            self?.stopSpinner()
        }
    }
    
    func failure(error: Error) {
        showAlert(message: error.localizedDescription)
        stopSpinner()
    }
    
    private func startSpinner() {
        activityIndicator.hidesWhenStopped = false
        activityIndicator.startAnimating()
    }
    
    private func stopSpinner() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func makeLivePhoto(imageUrl: URL, movieUrl: URL, previewImage: UIImage, completion: @escaping (_ livePhoto: PHLivePhoto) -> Void) {
        
        PHLivePhoto.request(withResourceFileURLs: [imageUrl, movieUrl],
                            placeholderImage: previewImage,
                            targetSize: CGSize.zero,
                            contentMode: .aspectFill) { livePhoto, infoDictionary in
            guard let livePhoto = livePhoto else { return }
            completion(livePhoto)
        }
    }
    
    @IBAction func saveButton() {
        PHPhotoLibrary.shared().performChanges({ [weak self] in
            guard let self = self,
                  let filePhotoUrl = self.presenter.filePhotoUrl,
                  let fileMovieUrl = self.presenter.fileMovieUrl else { return }
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: PHAssetResourceType.photo, fileURL: filePhotoUrl, options: nil)
            request.addResource(with: PHAssetResourceType.pairedVideo, fileURL: fileMovieUrl, options: nil)
            DispatchQueue.main.async {
                self.showAlert(message: "Saved")
            }
        })
    }
}
