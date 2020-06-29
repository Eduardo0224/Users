//
//  PostCD+CoreDataProperties.swift
//  Users
//
//  Created by Eduardo Andrade on 29/06/20.
//
//

import Foundation
import CoreData


extension PostCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCD> {
        return NSFetchRequest<PostCD>(entityName: "Post")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16
    @NSManaged public var user: UserCD?

}
