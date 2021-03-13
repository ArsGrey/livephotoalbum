//
//  VCExtension.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 13.03.2021.
//

import UIKit

extension UIViewController {
    class func loadFromDiStoryboard() -> Self {
        let storyboard: UIStoryboard = ApplicationDI.container.resolve(tag: self)
        if let vc = storyboard.instantiateInitialViewController() as? Self {
            return vc
        } else if let vc = storyboard.instantiateViewController(withIdentifier: "\(self)") as? Self {
            return vc
        } else {
            fatalError("\(self) not found")
        }
    }
}
