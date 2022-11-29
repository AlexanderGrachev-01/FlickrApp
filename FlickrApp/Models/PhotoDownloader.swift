//
//  PhotoDownloader.swift
//  FlickrApp
//
//  Created by Aleksandr.Grachev on 29.11.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PhotoDownloader {
    
    let url = "https://www.flickr.com/services/feeds/photos_public.gne?format=json"
//    let url = "https://rickandmortyapi.com/api/character"
    
    let headers: HTTPHeaders = [
        "Host": "www.flickr.com"
    ]

    
    func loadPhotos(tags: String? = nil, completion: (([Photo]?) -> Void)? = nil) {
    
        AF.request(url, headers: headers).response { (response) -> Void in
            switch response.result {
            case .success(_):
                guard let data = response.data,
                      var jsonstring = String(data: data, encoding: String.Encoding.utf8) else {
                    print("Data parsing error")
                    completion?(nil)
                    return
                }
                jsonstring.removeFirst(15)
                jsonstring.removeLast()
                let json = JSON.init(parseJSON: jsonstring)

                let photosJSON = json["items"]
                let photos = photosJSON.arrayValue.compactMap { Photo(json: $0) }
                completion?(photos)

            case .failure(let error):
                print("Fetching error \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
}
