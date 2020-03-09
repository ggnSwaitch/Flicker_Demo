//
//  SearchViewController+WebService.swift
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation

extension SearchViewController {
    
    func callSearchApi (searchText: String, pageNo: Int) {
        self.vm.getImageInfo(text: searchText, pageNo: pageNo) { (results:FlickrSearchResults?, paging: Paging?)  in
            
            self.searchTextField.stopAnimating()
            if let paging = paging, paging.currentPage == 1 {
                ImageDownloadManager.shared.cancelAll()
                self.photosCollectionView?.reloadData()
            }
            
            if let results = results {
                // results get logged and added to the front of the searches array
                print("Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.searchResults.append(contentsOf: results.searchResults)
                for photo in self.searches.searchResults {
                    print("URL:  \(photo.flickrImageURL()?.absoluteString ?? "")")
                }
                self.paging = paging
                self.photosCollectionView?.reloadData()
                
            }
            self.loadMore = false
        }
        
    }
}
