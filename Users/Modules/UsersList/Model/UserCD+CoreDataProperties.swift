//
//  UserCD+CoreDataProperties.swift
//  Users
//
//  Created by Eduardo Andrade on 29/06/20.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged @objc public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var website: String?
    @NSManaged public var posts: NSOrderedSet?

}

// MARK: Generated accessors for posts
extension UserCD {

    @objc(insertObject:inPostsAtIndex:)
    @NSManaged public func insertIntoPosts(_ value: PostCD, at idx: Int)

    @objc(removeObjectFromPostsAtIndex:)
    @NSManaged public func removeFromPosts(at idx: Int)

    @objc(insertPosts:atIndexes:)
    @NSManaged public func insertIntoPosts(_ values: [PostCD], at indexes: NSIndexSet)

    @objc(removePostsAtIndexes:)
    @NSManaged public func removeFromPosts(at indexes: NSIndexSet)

    @objc(replaceObjectInPostsAtIndex:withObject:)
    @NSManaged public func replacePosts(at idx: Int, with value: PostCD)

    @objc(replacePostsAtIndexes:withPosts:)
    @NSManaged public func replacePosts(at indexes: NSIndexSet, with values: [PostCD])

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: PostCD)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: PostCD)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSOrderedSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSOrderedSet)

}
