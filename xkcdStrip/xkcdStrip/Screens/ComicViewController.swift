//
//  LatestStripViewController.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import UIKit
import Combine

class ComicViewController: UIViewController {
    private var subscriptions = [AnyCancellable]()
    private var api = API()
    
    override func loadView() {
        view = ComicView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        
        api.comic()
            .receive(on: DispatchQueue.main, options: .none)
            .sink { completion in
                print(completion)
            } receiveValue: { currentComic in
                (self.view as! ComicView).setComic(comic: currentComic)
            }
            .store(in: &subscriptions)
    }
    
    private func configureViewController(){
      
    }
}
