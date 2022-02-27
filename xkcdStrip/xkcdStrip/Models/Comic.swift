//
//  Strip.swift
//  xkcdStrip
//
//  Created by J Manuel Zaragoza on 2/26/22.
//

import Foundation
import UIKit

struct Comic: Codable, Comparable {
 
    let stripNumber: Int
    let transcript: String
    let alternateTranscript: String
    let stripImageURLString: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title, transcript
        case stripNumber = "num"
        case alternateTranscript = "alt"
        case stripImageURLString = "img"
    }
    
    static func < (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.stripNumber < rhs.stripNumber
    }
    
}

extension Comic {
    static func newInstance() -> Comic {
        Comic(stripNumber: 0, transcript: "", alternateTranscript: "", stripImageURLString: "", title: "")
    }
}
