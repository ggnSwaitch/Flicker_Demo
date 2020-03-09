//
//  ViewController.swift
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: SearchTextField!
    
    let vm = PhotosViewModel()
    let downloadvm = DownloadPhotoViewModel()
    var searches = FlickrSearchResults()
    var itemsPerRow: CGFloat = 3
    var paging : Paging?
    var searchText: String = ""
    var loadMore: Bool = false
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    var searchController = UISearchController()
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextField.delegate = self
        self.photosCollectionView.dataSource = self
        self.photosCollectionView.delegate = self 
        searchController.hidesNavigationBarDuringPresentation = false
    }
}


// MARK: UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.paging = nil
        self.loadMore = true
        self.searches.searchResults.removeAll()
        guard let searchText = textField.text, searchText.count > 0 else {
            ImageDownloadManager.shared.cancelAll()
            self.photosCollectionView?.reloadData()
            self.photosCollectionView.layoutIfNeeded()
            self.loadMore = false
            return true
        }
        searchTextField.startAnimating()
        self.callSearchApi(searchText: searchText, pageNo: 1)
        
        return true
    }
}
