//
//  APIService.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import Foundation
import Combine
import UIKit

struct API {
    private enum Endpoint {
        static let baseURL = URL(string:"https://xkcd.com/")!
        
        case current
        case comic(Int)
        
        var url: URL {
            switch self {
            case .current:
                return Endpoint.baseURL.appendingPathComponent("info.0.json")
            case .comic(let comicNumber):
                return Endpoint.baseURL.appendingPathComponent("\(comicNumber)/info.0.json")
            }
        }
    }
    
    private var lastestComicNumber: Int = 0

    private let backgroundDecodingQueue = DispatchQueue(label: "BackgroundDecoder", qos: .background, attributes: .concurrent)
    private let decoder = JSONDecoder()
    
    
    func comic(id: Int = 0) -> AnyPublisher<Comic, Error> {
        URLSession.shared
            .dataTaskPublisher(for: id == 0 ? Endpoint.current.url : Endpoint.comic(id).url)
            .receive(on: backgroundDecodingQueue)
            .map(\.data)
            .decode(type: Comic.self, decoder: decoder)
            .catch({ _ in Empty<Comic, Error> ()})
            .eraseToAnyPublisher()
    }
    
    func mergeComics(comicNumbers: [Int]) -> AnyPublisher<Comic, Error> {
        let firstTenComics = Array(comicNumbers.prefix(10))
        
        let initialPub = comic(id: firstTenComics.first!)
        let remainingComics = Array(comicNumbers.dropFirst())
        
        return remainingComics.reduce(initialPub) { partialResult, comicNumber in
            return partialResult
                .merge(with: comic(id: comicNumber))
                .eraseToAnyPublisher()
        }
    }
    
    func allComics() -> AnyPublisher<[Comic], Error> {
        return mergeComics(comicNumbers: Array(1...100))
            .scan([]) { comics, comic in
                return comics + [comic]
            }
            .map({ $0.sorted() })
            .eraseToAnyPublisher()
    }
}
