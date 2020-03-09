
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//


import UIKit

class FlickrPhoto : Equatable {
    let photoID : String
    let farm : Int
    let server : String
    let secret : String
    let title : String
    
    init (photoID:String,farm:Int, server:String, secret:String, title: String) {
        self.photoID = photoID
        self.farm = farm
        self.server = server
        self.secret = secret
        self.title = title
    }
    
    func flickrImageURL(_ size:String = "m") -> URL? {
        if let url =  URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg") {
            return url
        }
        return nil
    }
    
}

func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
    return lhs.photoID == rhs.photoID
}
