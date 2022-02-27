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
        
        (view as! ComicView).setComic(comic: comic)
    }

    private func configureViewController(){
        view.backgroundColor = .systemBackground
    }
}
