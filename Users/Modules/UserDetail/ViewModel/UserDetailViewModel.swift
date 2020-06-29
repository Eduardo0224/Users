//
//  UserDetailViewModel.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import Foundation
import CoreData

class UserDetailViewModel {
    
    // MARK: - Properties
    /// API Connection
    private let connection = UserDetailConnection()
    lazy var post: (Int) -> Post = { self.posts[$0] }
    private(set) var posts = [Post]()
    private let managedContext: NSManagedObjectContext
    var user: User?
    private var userEntity: UserCD?
    
    // MARK: - Inits
    init() {
        // initPostsWithMock()
        managedContext = AppDelegate.shared.persistentContainer.viewContext
    }
    
    // MARK: - Custom Functions
    private func initPostsWithMock() {
        do {
            self.posts = try JSONDecoder().decode([Post].self, from: Data(PostsMock.json))
            print(posts)
        } catch let error {
            print(error)
        }
    }
    
    /**
     ## Get posts list
     Makes use of networking to retrieve  the all user's posts
     
     - Parameter onComplete: closure that is invoked when the fetch posts process is completed
     - Parameter onFailure: closure that is invoked when the fetch posts process have a error **UsersAPI.NetworkError**
     */
    func getPostsList(by id: Int,
                      onComplete: @escaping () -> Void,
                      onFailure: @escaping (UsersAPI.NetworkError) -> Void) {
        
        guard let userToSearch = user else { onFailure(.unknownError); return }

        let fetchRequestSpecificUser: NSFetchRequest<UserCD> = UserCD.fetchRequest()
        fetchRequestSpecificUser.predicate = .init(format: "%K == %i", #keyPath(UserCD.id), userToSearch.id)

        do {
            let usersFinded = try managedContext.fetch(fetchRequestSpecificUser)
            self.userEntity = usersFinded.first

            guard let postsRetrieve = userEntity?.posts else { onFailure(.unknownError); return }

            if postsRetrieve.count > 0 {
                self.posts = postsRetrieve
                .compactMap { $0 as? PostCD }
                .compactMap { Post(id: Int($0.id), userId: Int($0.userId), title: $0.title ?? "", body: $0.body ?? "") }
                onComplete()
                return
            }
        } catch {
            onFailure(.unknownError)
        }

        connection.getPostsList(by: id) { result in
            switch result {
            case .success(let posts):
                if  posts.count > 0 {
                    self.saveLocally(to: posts, of: self.userEntity, onFailure)
                    posts.forEach { self.posts.append($0) }
                }
                onComplete()
            case .failure(let error):
                onFailure(error)
            }
        }
    }

    private func saveLocally(to posts: [Post], of user: UserCD?, _ onFailure: (UsersAPI.NetworkError) -> Void) {
        guard let user = user else { return }
        var postsEntities = [PostCD]()
        posts.forEach {
            let postEntity = PostCD(context: self.managedContext)
            postEntity.id = Int16($0.id)
            postEntity.userId = Int16($0.userId)
            postEntity.title = $0.title
            postEntity.body = $0.body
            postsEntities.append(postEntity)
        }

        guard let userPosts = user.posts?.mutableCopy() as? NSMutableOrderedSet else { onFailure(.unknownError); return }
        postsEntities.forEach { userPosts.add($0) }
        user.posts = userPosts

        do {
            try self.managedContext.save()
        } catch {
            onFailure(.unknownError)
        }
    }
}
