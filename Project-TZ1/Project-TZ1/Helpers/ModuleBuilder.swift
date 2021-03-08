//
//  ModuleBuilder.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(photo: Photos) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let mainViewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let networkService = NetworkService()
        let presenter = MainPresenter(view: mainViewController, networkService: networkService)
        mainViewController.presenter = presenter
        return mainViewController
    }
    
    static func createDetailModule(photo: Photos) -> UIViewController {
        let detailViewController = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: detailViewController, networkService: networkService, photo: photo)
        detailViewController.presenter = presenter
        return detailViewController
    }
}
