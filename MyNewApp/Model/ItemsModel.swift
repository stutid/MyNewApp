//
//  ItemsModel.swift
//  MyNewApp
//
//  Created by Stuti on 29/06/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation

/*
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
        }
        else{
            self.imageData = ItemsImageModel([:], isImageAvailable: false)
        }

        self.title = jsonDict["title"] as? String
        self.price = jsonDict["price"] as? Int

        if let locationDict = jsonDict["location"] as? [String: Any] {
            self.address = locationDict["address"] as? String
        }
    }
}*/

//------------------

struct Items: Decodable {
    let items: [ItemsModelStruct]
}


struct ItemsModelStruct: Decodable {

    let titleName: String?
    let priceValue: Int?
    let addressNum: String?

    private enum CodingKeys: String, CodingKey {
        case titleName = "title"
        case priceValue = "price"
        case addressNum = "address"
        case location
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        titleName = try container.decode(String.self, forKey: .titleName)
        priceValue = try container.decode(Int.self, forKey: .priceValue)
        
        let locations = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        addressNum = try locations.decode(String.self, forKey: .addressNum)
        
    }
    
}









