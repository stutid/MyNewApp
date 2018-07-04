//
//  FlatItems.swift
//  MyNewApp
//
//  Created by Stuti on 04/07/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation
import CoreData

extension FlatItems {
    
    class func saveItemsInDatabase(for item: [String: AnyObject]) {
        
        let myContext = CoreDataStack.sharedInstance.backgroundQueueContext
            let id = item["id"] as? Int16
            let price = item["price"] as? Int16
            let title = item["title"] as? String
        
            let flatitem = FlatItems(context: myContext)
            flatitem.id = id!
            flatitem.price = price!
            flatitem.title = title
        
        
        if let arrImage = item["images"] as? [[String: Any]] {
            for image in arrImage {
                let fI = FlatImages.saveImagesinDatabase(for: image, and: flatitem, with: myContext)
                flatitem.addToImages(fI)
            }
        }
        
        
        let dictLocations = item["location"] as? [String: Any]
        let fL = FlatLocation.saveLocationInDatabase(for: dictLocations!, and: flatitem, with: myContext)
        flatitem.location = fL
        
        do {
            try myContext.save()
        }
        catch {
            
        }
    }
    
    
    class func fetchItems() -> [FlatItems]? {
        
        let myNewContext = CoreDataStack.sharedInstance.mainQueueContext
        let request: NSFetchRequest<FlatItems> = NSFetchRequest(entityName: "FlatItems")
        do {
            let requestResult = try myNewContext.fetch(request)
            return requestResult
        }
        catch {
        }
        return nil
    }
    
    
    
    
    
}
