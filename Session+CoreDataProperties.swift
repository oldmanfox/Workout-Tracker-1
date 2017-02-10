//
//  Session+CoreDataProperties.swift
//  90 DWT 1
//
//  Created by Grant, Jared on 2/2/17.
//  Copyright © 2017 Grant, Jared. All rights reserved.
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session");
    }

    @NSManaged public var currentSession: String?
    @NSManaged public var date: NSDate?

}