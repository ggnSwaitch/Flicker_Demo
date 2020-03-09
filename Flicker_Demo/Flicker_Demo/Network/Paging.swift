//
//  Paging.swift
//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation

public class Paging {

    // MARK: Properties
    public var totalPages: Int?
    public var numberOfElements: Int32?
    public var currentSize: Int = 15
    public var currentPage: Int?

    init(totalPages: Int, elements: Int32, currentPage: Int) {
        self.totalPages = totalPages
        self.numberOfElements = elements
        self.currentPage = currentPage
    }
}
