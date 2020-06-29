//
//  UserDetailConnection.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import Foundation

class UserDetailConnection {

    // MARK: - Custom Functions
    func getPostsList(by id: Int, completion: @escaping (ResultConnection<[Post]>) -> Void) {
        guard let url = UsersAPI.Endpoints.getPosts(id).url else {
            completion(.failure(.urlNilError))
            return
        }
        UsersAPI.taskForGETRequest(in: url, response: [Post].self, completion: completion)
    }
}
