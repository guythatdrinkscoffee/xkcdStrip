//
//  ComicDetailViewController.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/27/22.
//

import UIKit

class ComicDetailViewController: UIViewController {
    
    //MARK: - PROPERTIES
    var comic: Comic!

    
    //MARK: - LIFECYCLE
    convenience init(comic: Comic?){
        self.init(nibName: nil, bundle: nil)
        
        if let comic = comic {
            self.comic = comic
        }
    }
    
    override func loadView() {
        super.loadView()
        view = ComicView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureViewController()
        configureNavigationItems()
        
        (view as! ComicView).setComic(comic: comic)
    }

    //MARK: - CONFIGURATION
    private func configureNavigationItems() {
        let shareBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
        navigationItem.rightBarButtonItem = shareBarButton
    }
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - SELECTOR METHODS
    @objc private func shareButtonTapped(_ sender: UIBarButtonItem){
        let image = (view as! ComicView).comicImage
        share(image: image)
    }
}

extension ComicDetailViewController: Shareable {
    func share(image: UIImage?) {
        let shareItems: [UIImage?] = [image]
        let actionController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        self.present(actionController, animated: true, completion: nil)
    }
}
