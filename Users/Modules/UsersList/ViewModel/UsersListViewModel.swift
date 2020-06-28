//
//  UsersListViewModel.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import Foundation

class UsersListViewModel {

    // MARK: - Properties
    /// API Connection
    private let connection = UsersListConnection()
    lazy var user: (Int) -> User = { self.filteredUsers[$0] }
    private var users = [User]()
    private(set) var filteredUsers = [User]()

    // MARK: - Inits
    init() {
        // initUserWithMock()
    }

    // MARK: - Custom Functions
    private func initUserWithMock() {
        do {
            self.users = try JSONDecoder().decode([User].self, from: Data(UsersMock.json))
            resetFilteredUsersList()
        } catch  { }
    }

    func resetFilteredUsersList() {
        filteredUsers = users
    }

    /**
     ## Get users list
     Makes use of networking to retrieve  the all users

     - Parameter onComplete: closure that is invoked when the fetch users process is completed
     - Parameter onFailure: closure that is invoked when the fetch users process have a error **UsersAPI.NetworkError**
     */
    func getUserList(onComplete: @escaping () -> Void,
                     onFailure: @escaping (UsersAPI.NetworkError) -> Void) {
        connection.getUsersList { result in
            switch result {
            case .success(let users):
                if  users.count > 0 {
                    users.forEach { self.filteredUsers.append($0) }
                    users.forEach { self.users.append($0) }
                }
                onComplete()
            case .failure(let error):
                onFailure(error)
            }
        }
    }

    /**
     ## Get user indicasting a search criteria
     based on a  search string criteria retrive a user tha name is matched

     - Parameter by: the search criteria **(String)**
     - Parameter onComplete: closure that is invoked when the search user process is completed
     */
    func getUser(by criteria: String,
                 onComplete: @escaping () -> Void) {
        filteredUsers = criteria.isEmpty ? users : users.filter { $0.name
            .lowercased()
            .trimmingCharacters(in: .whitespaces)
            .contains(criteria
                        .lowercased()
                        .trimmingCharacters(in: .whitespaces))

        }
        onComplete()
    }
}
