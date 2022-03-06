//
//  LatestStripViewController.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import UIKit
import Combine

class LatestComicViewController: UIViewController {
    
    //MARK: - PROPERTIES
    private var subscriptions = [AnyCancellable]()
    private var defaults = UserDefaults.standard
    private var api = API()
    
    //MARK: - LIFE CYCLE
    
    override func loadView() {
        view = ComicView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureNavigationItems()
        
        api.comic()
            .receive(on: DispatchQueue.main, options: .none)
            .sink { completion in
                print(completion)
            } receiveValue: { currentComic in
                (self.view as! ComicView).setComic(comic: currentComic)
            }
            .store(in: &subscriptions)
    }
    
    //MARK: - CONFIGURATION
    
    private func configureViewController(){
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationItems() {
        let shareBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
        navigationItem.rightBarButtonItem = shareBarButton
    }
    
    //MARK: - SELECTOR METHODS
    @objc private func shareButtonTapped(_ sender: UIBarButtonItem){
        let image = (view as! ComicView).comicImage
        share(image: image)
    }
}

//MARK: - EXTENSIONS

extension LatestComicViewController: Shareable {
    func share(image: UIImage?) {
        let shareItems: [UIImage?] = [image]
        let actionController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        self.present(actionController, animated: true, completion: nil)
    }
}
