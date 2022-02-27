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
        viewControllers = [configureLatestStripVC()]
    }
    
    private func configureLatestStripVC() -> UINavigationController {
        let currentComicVC = ComicViewController()
        let containerNav = UINavigationController(rootViewController: currentComicVC)
        return containerNav
    }
}

