//
//  ComicView.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import UIKit
import Combine

class ComicView: UIView {
    
    private var comicSubscriber: AnyCancellable?
    
    private lazy var scrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    private lazy var contentView : UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var comicTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    
    private lazy var comicImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = false
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - LAYOUT
    private func layoutUI() {
        //Add the scrollview to the view
        addSubview(scrollView)
        
        //Add the contentview to the scroll view
        scrollView.addSubview(contentView)
        
        //Add the content's views
        contentView.addSubview(comicTitleLabel)
        contentView.addSubview(comicImageView)
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            comicTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            comicTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            comicTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            comicTitleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            comicImageView.topAnchor.constraint(equalTo: comicTitleLabel.topAnchor, constant: 50),
            comicImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            comicImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            comicImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 90),
            activityIndicator.widthAnchor.constraint(equalTo:activityIndicator.heightAnchor)
            
        ])
    }
    
    func setComic(comic: Comic) {
        comicSubscriber = ImageLoader
            .loadImage(for: comic)
            .receive(on: DispatchQueue.main, options: .none)
            .handleEvents(receiveSubscription: { _ in
                self.activityIndicator.startAnimating()
            },receiveCompletion: { _ in
                self.activityIndicator.stopAnimating()
            })
            .sink(receiveValue: { image in
                self.updateUI(comic: comic, image: image)
            })
    }
    
    private func updateUI(comic: Comic, image: UIImage?){
        comicTitleLabel.text = comic.title
        comicImageView.image = image
    }
}
