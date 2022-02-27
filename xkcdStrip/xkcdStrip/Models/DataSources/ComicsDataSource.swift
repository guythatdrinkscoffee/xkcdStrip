//
//  ComicsDataSource.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/27/22.
//

import Foundation
import UIKit

class ComicsDataSource: NSObject, UITableViewDataSource {
    public var comics: [Comic] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.resueIdentifier, for: indexPath) as! ComicTableViewCell
        let comic = comics[indexPath.row]
        
        cell.configure(for: comic)
        
        return cell
    }

    
    
}
