//
//  ComicTableViewCell.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/27/22.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    static let resueIdentifier = "ComicCell"
    
    private lazy var comicNumberLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private lazy var comicTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(comicNumberLabel)
        contentView.addSubview(comicTitleLabel)
        
        NSLayoutConstraint.activate([
            comicNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            comicNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            comicNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            comicNumberLabel.bottomAnchor.constraint(equalTo: comicTitleLabel.topAnchor),
            
            comicTitleLabel.topAnchor.constraint(equalTo: comicNumberLabel.bottomAnchor),
            comicTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            comicTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            comicTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    

    public func configure(for comic: Comic){
        comicNumberLabel.text = "Comic Number: \(comic.stripNumber)"
        comicTitleLabel.text = comic.title
    }
}
