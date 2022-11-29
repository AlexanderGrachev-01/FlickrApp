//
//  Photo.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 29.11.2022.
//

import Foundation
import SwiftyJSON

class Photo {
    var imageURL: String
    var name: String
    var date: String
    var tags: String
    
    init?(json: JSON) {
        guard let imageURL = json["media"]["m"].string,
              let name = json["title"].string,
              let date = json["date_taken"].string,
              let tags = json["tags"].string
        else { return  nil }
        
        self.imageURL = imageURL
        self.name = name
        self.date = date
        self.tags = tags
    }
}
