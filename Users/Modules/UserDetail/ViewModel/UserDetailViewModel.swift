//
//  UserDetailViewModel.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import Foundation

class UserDetailViewModel {
    
    // MARK: - Properties
    /// API Connection
    private let connection = UserDetailConnection()
    lazy var post: (Int) -> Post = { self.posts[$0] }
    private(set) var posts = [Post]()
    
    // MARK: - Inits
    init() {
        // initPostsWithMock()
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
        connection.getPostsList(by: id) { result in
            switch result {
            case .success(let posts):
                if  posts.count > 0 {
                    posts.forEach { self.posts.append($0) }
                }
                onComplete()
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
