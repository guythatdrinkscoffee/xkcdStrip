//
//  ViewController.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureViewController()
    }

    //MARK: - CONFIGURATION
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        viewControllers = [configureComicVC(), configureComicArchiveVC()]
    }
    
    private func configureComicVC() -> UINavigationController {
        let currentComicVC = ComicViewController()
        currentComicVC.tabBarItem = UITabBarItem(title: "Current Comic", image: UIImage(systemName: "newspaper"), tag: 0)
        let containerNav = UINavigationController(rootViewController: currentComicVC)
        return containerNav
    }
    
    private func configureComicArchiveVC() -> UINavigationController {
        let comicArchiveVC = ComicArchiveViewController()
        comicArchiveVC.title = "Archive"
        comicArchiveVC.tabBarItem = UITabBarItem(title: "Comic Archive", image: UIImage(systemName: "archivebox"), tag: 1)
        let containerNav = UINavigationController(rootViewController: comicArchiveVC)
        return containerNav
    }
}

