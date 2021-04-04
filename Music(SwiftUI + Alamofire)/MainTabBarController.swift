//
//  MainTabBarController.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 03.04.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 0.9725490196, green: 0.2509803922, blue: 0.3725490196, alpha: 1)
        
        let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
        
        viewControllers = [
            customizationViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "Search"), title: "Search"), customizationViewController(rootViewController: LibraryViewController(), image: #imageLiteral(resourceName: "Library - Selected"), title: "Library")
        ]
        
    }
    
    private func customizationViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.tabBarItem.image = image
        navigationViewController.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationViewController.navigationBar.prefersLargeTitles = true
        return navigationViewController
    }
}
