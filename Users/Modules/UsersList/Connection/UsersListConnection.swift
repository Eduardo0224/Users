//
//  UsersListConnection.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import Foundation

class UsersListConnection {
    
    // MARK: - Custom Functions
    func getUsersList(completion: @escaping (ResultConnection<[User]>) -> Void) {
        guard let url = UsersAPI.Endpoints.getUsers.url else {
            completion(.failure(.urlNilError))
            return
        }
        UsersAPI.taskForGETRequest(in: url, response: [User].self, completion: completion)
    }
}
