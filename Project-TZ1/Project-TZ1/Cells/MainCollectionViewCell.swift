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
    
    func set(data: Data) {
        self.photoView.image = UIImage(data: data)
    }
}
