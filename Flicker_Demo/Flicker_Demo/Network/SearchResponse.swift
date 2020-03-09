//
//  Created by Gagandeep Kaur Swaitch
//  Copyright © 2019 Gagandeep Kaur Swaitch. All rights reserved.
//

import Foundation

struct SearchResponse: Codable
{
    struct Photos: Codable {
        var page: Int?
        var pages: Int?
        var total: String?
        var photo: [Photo]
        }
     var photos:Photos
}
      
struct Photo: Codable{
    var title: String
    var server: String
    var secret: String
    var farm: Int
    var id: String
}

