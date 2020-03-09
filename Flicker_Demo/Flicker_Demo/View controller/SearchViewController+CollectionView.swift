//
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation
import UIKit


// MARK: UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrPhotoCell.identifier, for: indexPath) as! FlickrPhotoCell
        
        cell.photoTitle!.lineBreakMode = .byWordWrapping
        cell.photoTitle!.numberOfLines = 2
        return cell
        
    }
    
}

// MARK: UICollectionViewDelegate
extension SearchViewController {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRowIndex = collectionView.numberOfItems(inSection: 0) - 1
        if indexPath.row == lastRowIndex && paging != nil {
            loadMorePhotos()
        }
        
        let flickrPhoto = photoForIndexPath(indexPath: indexPath)
        (cell as! FlickrPhotoCell).imageView.image = #imageLiteral(resourceName: "placeholder")
        
        self.downloadvm.downloadPhoto(flickrPhoto: flickrPhoto, indexPath: indexPath, title: flickrPhoto.title) {  (image: UIImage?, title:String?, indexPath: IndexPath?)   in
            if let indexPathNew = indexPath {
                DispatchQueue.main.async {
                    if let getCell = collectionView.cellForItem(at: indexPathNew) {
                        (getCell as? FlickrPhotoCell)!.imageView.image = image
                        (getCell as? FlickrPhotoCell)!.photoTitle.text = title
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        /* Reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
        if self.loadMore {return}
        let flickrPhoto = photoForIndexPath(indexPath: indexPath)
        ImageDownloadManager.shared.slowDownImageDownloadTaskfor(flickrPhoto)
    }
    
    
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return searches.searchResults[(indexPath as NSIndexPath).row]
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    // responsible for telling the layout the size of a given cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // there will be n + 1 evenly sized spaces, where n is the number of items in the row
        // the space size can be taken from the left section inset
        // subtracting this from the view's width and dividing by the number of items in a row gives you the width for each item
       
        var paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        if UIDevice.current.orientation.isLandscape {
              paddingSpace = sectionInsets.left * (itemsPerRow + 10)
        }
        
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        // return the size as a square
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // return the spacing between the cells, headers, and footers. Used a constant for that
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // controls the spacing between each line in the layout. this should be matched the padding at the left and right
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.loadMore {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
    
    
    // MARK: - Helper Method
    private func loadMorePhotos() {
        guard let searchText = self.searchTextField.text, searchText.count > 0 else {
            return
        }
        if !loadMore && paging!.currentPage! < paging!.totalPages! {
            loadMore = true
            self.callSearchApi(searchText: searchText, pageNo: paging!.currentPage! + 1)
        }
    }
    
}


