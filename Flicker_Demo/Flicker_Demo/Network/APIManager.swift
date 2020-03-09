//
//  APIManager.swift
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation

protocol APIManagerProtocol {
    
    func getImages(text:String, pageNo: Int, complete:@escaping (FlickrSearchResults, Paging?,_ error : NSError?) -> Void)
}


class APIManager {
    static let apiKey = "96358825614a5d3b1a1c3fd87fca2b47"
    
    let rest = RestHandler()
    
    /*!
     Load Image info Data
     */
    func getImages(text:String, pageNo: Int, complete:@escaping (FlickrSearchResults, Paging?,_ error : NSError?) -> Void)  {
        
        var paging : Paging?
        var flickrPhotos = [FlickrPhoto]()
        
        let fullPath = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key="+APIManager.self.apiKey+"&text="+text+"&format=json&nojsoncallback=1&per_page=20&page=\(pageNo)"
        
        guard let url = URL(string: fullPath) else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                
                let response = try! JSONDecoder().decode(SearchResponse.self, from: data)
                print (response)
                if let currentPage = response.photos.page,
                    let totalPages = response.photos.pages ,
                    let numberOfElements = response.photos.total {
                    paging = Paging(totalPages: totalPages, elements: Int32(numberOfElements)!, currentPage: currentPage)
                }
                
                for photo in response.photos.photo{
                    
                    let flickrPhoto = FlickrPhoto(photoID: photo.id, farm: photo.farm, server: photo.server, secret: photo.secret, title: photo.title)
                    flickrPhotos.append(flickrPhoto)
                    
                }
                DispatchQueue.main.sync {
                    complete(FlickrSearchResults(searchResults: flickrPhotos), paging, nil)
                }
                
            }
        }
    }
}
