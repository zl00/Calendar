//
//  DailyUpdate+CoreDataProperties.swift
//  
//
//  Created by 龚莎 on 16/8/12.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension DailyUpdate {

    @NSManaged var date: NSTimeInterval
    @NSManaged var createdAt: NSTimeInterval
    @NSManaged var updatedAt: NSTimeInterval
    @NSManaged var creatorId: String
    @NSManaged var relationship: NSManagedObject?

}
