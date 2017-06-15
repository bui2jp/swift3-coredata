//
//  EntityVeg+CoreDataProperties.swift
//  coreDataTest
//
//  Created by Takuya on 2017/06/13.
//  Copyright © 2017 Takuya. All rights reserved.
//

import Foundation
import CoreData


extension EntityVeg {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityVeg> {
        return NSFetchRequest<EntityVeg>(entityName: "EntityVeg")
    }

    @NSManaged public var dateST: NSDate?
    @NSManaged public var name: String?

}
