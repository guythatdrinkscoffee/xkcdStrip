//
//  ComicListViewController.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import UIKit
import Combine

class ComicArchiveViewController: UIViewController {
    
    //MARK: - PROPERTIES
    
    private let api = API()
    private var comicsDataSource: ComicsDataSource!
    private var subscriptions = [AnyCancellable]()
    
    //MARK: - UI
    
    private lazy var comicArchiveTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = comicsDataSource
        tableView.rowHeight = 80
        tableView.register(ComicTableViewCell.self, forCellReuseIdentifier: ComicTableViewCell.resueIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    
    private lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = false
        return indicator
    }()
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsDataSource = ComicsDataSource()
        
        layoutUI()
        
        api
            .allComics()
            .handleEvents(receiveSubscription: { _ in
                DispatchQueue.main.async {
                    self.activityIndicator.startAnimating()
                }
            }, receiveCompletion: { _ in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.comicArchiveTableView.isHidden = false
                    self.comicArchiveTableView.reloadData()
                }
            })
            .sink { completion in
                print(completion)
            } receiveValue: { comics in
                DispatchQueue.main.async {
                    self.updateTableView(with: comics)
                }
            }
            .store(in: &subscriptions)
        
    }
    
    //MARK: - LAYOUT
    
    private func layoutUI() {
        view.addSubview(activityIndicator)
        view.addSubview(comicArchiveTableView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            comicArchiveTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            comicArchiveTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            comicArchiveTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            comicArchiveTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - MEMBER FUNCTIONS
    private func updateTableView(with comics: [Comic]){
        comicsDataSource.comics = comics
    }
}

//MARK: - EXTENSIONS

extension ComicArchiveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic = comicsDataSource.comics[indexPath.row]
        let comicViewController = ComicDetailViewController(comic: comic)
        
        navigationController?.pushViewController(comicViewController, animated: true)
    }
}
