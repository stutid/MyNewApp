//
//  ItemsImageModel.swift
//  MyNewApp
//
//  Created by Stuti on 29/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation

class ItemsImageModel {
    
    var id: Int?
    var url: String?
    
    init(_ jsonImageDict: [String: Any]) {
        self.url = "https://i.ytimg.com/vi/UgsRYV7Xjv8/maxresdefault.jpg"
        //jsonImageDict["url"] as? String
        self.id = jsonImageDict["id"] as? Int
    }
    
}
