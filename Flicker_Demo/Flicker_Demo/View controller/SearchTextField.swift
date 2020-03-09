//
//  SearchTextField.swift

//  Copyright © 2020 GaGan. All rights reserved.
//

import Foundation
import UIKit

class SearchTextField: UITextField {
    var activityIndicator : UIActivityIndicatorView!
    
    override func awakeFromNib() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.frame = self.bounds
    }
    
    func startAnimating () {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating () {
        activityIndicator.stopAnimating()
    }

}
