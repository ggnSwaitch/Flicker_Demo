//
//  photoDownloadViewModel.swift
//  Flicker_Demo
//
//  Created by GaGan on 9/3/20.
//  Copyright © 2020 GaGan. All rights reserved.
//

import Foundation
import UIKit

class DownloadPhotoViewModel {
    
    func downloadPhoto(flickrPhoto: FlickrPhoto, indexPath: IndexPath,title: String, complete : @escaping(_ image: UIImage?, _ title: String ,_ indexPath: IndexPath )-> Void)  {
        
        ImageDownloadManager.shared.downloadImage(flickrPhoto, indexPath: indexPath, title: flickrPhoto.title) { (image, url, indexPath, title, error) in
            complete(image, title, indexPath!)
        }
    }
    
}
