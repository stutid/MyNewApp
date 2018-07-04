//
//  FlatLocation.swift
//  MyNewApp
//
//  Created by Stuti on 04/07/18.
//  Copyright © 2018 Stuti. All rights reserved.
//

import Foundation
import CoreData

extension FlatLocation {
    
    
    class func saveLocationInDatabase(for dict: [String: Any], and parentItem: FlatItems, with context: NSManagedObjectContext) -> FlatLocation {
        
        let address = dict["address"] as? String
        let latitude = dict["latitude"] as? Double
        let longitude = dict["longitude"] as? Double
        
        let flatLocation = FlatLocation(context: context)
        flatLocation.address = address
        flatLocation.latitude = latitude!
        flatLocation.longitude = longitude!
//        flatLocation.item = parentItem
//
//        do {
//            try CoreDataStack.sharedInstance.backgroundQueueContext.save()
//        }
//        catch {
//
//        }
        return flatLocation
    }
    
    
}
