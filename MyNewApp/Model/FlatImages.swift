//
//  FlatImages.swift
//  MyNewApp
//
//  Created by Stuti on 04/07/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation
import CoreData

extension FlatImages {
    
    class func saveImagesinDatabase(for image: [String: Any], and parentItem: FlatItems, with context: NSManagedObjectContext) -> FlatImages {
        
        let id = image["id"] as? Int16
        let url = image["url"] as? String
        
       let flatImage = FlatImages(context: context)
        flatImage.id = id!
        flatImage.url = url
//        flatImage.item = parentItem
        
        return flatImage
    }
    
}
