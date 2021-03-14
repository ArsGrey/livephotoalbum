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
        if let viewController = storyboard.instantiateInitialViewController() as? Self {
            return viewController
        } else if let viewController = storyboard.instantiateViewController(withIdentifier: "\(self)") as? Self {
            return viewController
        } else {
            fatalError("\(self) not found")
        }
    }
}
