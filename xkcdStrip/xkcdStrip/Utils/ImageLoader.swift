//
//  ImageLoader.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import Foundation
import UIKit
import Combine

struct ImageLoader {
    static private let backgroundImageQueue = DispatchQueue(label: "ImageBackgroundQueue", qos: .background, attributes: .concurrent)
    
    static func loadImage(for comic: Comic) -> AnyPublisher<UIImage, Never> {
        let imageURL = URL(string: comic.stripImageURLString)!
        
        return URLSession
            .shared
            .dataTaskPublisher(for: imageURL)
            .receive(on: backgroundImageQueue, options: .none)
            .map({$0.data})
            .map({ UIImage(data: $0)!})
            .catch({ err in
                return Just(UIImage())
            })
            .eraseToAnyPublisher()
    }
}
