//
//  StopsViewModel.swift
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation

class PhotosViewModel {
    
    let apiManager = APIManager()
    
    func getImageInfo(text: String, pageNo: Int, complete : @escaping(_ results: FlickrSearchResults?, _ paging: Paging)-> Void)  {
        apiManager.getImages(text: text, pageNo: pageNo) { (imagesInfo, paging, error)  in
            complete(imagesInfo, paging!)
        }
    }
    
}

