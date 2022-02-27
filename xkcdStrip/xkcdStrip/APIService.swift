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
    
    static private let backgroundDecodingQueue = DispatchQueue(label: "BackgroundDecoder", qos: .background, attributes: .concurrent)
    static private let decoder = JSONDecoder()
        
    static func comic(id: Int = 0) -> AnyPublisher<Comic, Error> {
        URLSession.shared
            .dataTaskPublisher(for: id == 0 ? Endpoint.current.url : Endpoint.comic(id).url)
            .receive(on: backgroundDecodingQueue)
            .map(\.data)
            .decode(type: Comic.self, decoder: decoder)
            .catch({ _ in Empty<Comic, Error> ()})
            .eraseToAnyPublisher()
    }
}
