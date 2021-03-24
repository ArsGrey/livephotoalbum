//
//  ModuleBuilder.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import UIKit

final class ModuleBuilder {
    static func createMainModule() -> MainViewController {
        MainViewController.loadFromDiStoryboard()
    }
    
    static func createDetailModule() -> DetailViewController {
        DetailViewController.loadFromDiStoryboard()
    }
}
