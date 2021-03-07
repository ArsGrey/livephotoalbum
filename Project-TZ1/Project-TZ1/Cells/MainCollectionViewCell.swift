//
//  MainCollectionViewCell.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 30.01.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with thumbnailUrl: String) {
        guard let url = URL(string: thumbnailUrl) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.photoView.image = UIImage(data: data)
            }
        } .resume()
    }
}
