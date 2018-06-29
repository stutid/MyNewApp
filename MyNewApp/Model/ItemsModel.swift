//
//  ItemsModel.swift
//  MyNewApp
//
//  Created by Stuti on 29/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation

class ItemsModel {
    
    var imageData: ItemsImageModel?
    var title: String?
    var price: Int?
    var address: String?
    
    init(_ jsonDict: [String: Any]) {
        if let imageArr = jsonDict["images"] as? [[String: Any]] {
            for image in imageArr {
                self.imageData = ItemsImageModel(image)
            }
            self.title = jsonDict["title"] as? String
            self.price = jsonDict["price"] as? Int
            
            if let locationDict = jsonDict["location"] as? [String: Any] {
                self.address = locationDict["address"] as? String
            }
        }
    }
}
