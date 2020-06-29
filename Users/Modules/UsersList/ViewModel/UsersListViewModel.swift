//
//  UsersListViewModel.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import Foundation
import UIKit
import CoreData

class UsersListViewModel {

    // MARK: - Properties
    /// API Connection
    private let connection = UsersListConnection()
    lazy var user: (Int) -> User = { self.filteredUsers[$0] }
    private var users = [User]()
    private(set) var filteredUsers = [User]()
    private let managedContext: NSManagedObjectContext

    // MARK: - Inits
    init() {
        // initUserWithMock()
        managedContext = AppDelegate.shared.persistentContainer.viewContext
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

    private func saveLocally(to users: [User], _ onFailure: (UsersAPI.NetworkError) -> Void) {
        var usersEntities = [UserCD]()
        users.forEach {
            let userEntity = UserCD(context: self.managedContext)
            userEntity.id = Int16($0.id)
            userEntity.name = $0.name
            userEntity.email = $0.email
            userEntity.phone = $0.phone
            userEntity.website = $0.website
            usersEntities.append(userEntity)
        }

        do {
            try self.managedContext.save()
        } catch {
            onFailure(.unknownError)
        }
    }

    /**
     ## Get users list
     Makes use of networking to retrieve  the all users

     - Parameter onComplete: closure that is invoked when the fetch users process is completed
     - Parameter onFailure: closure that is invoked when the fetch users process have a error **UsersAPI.NetworkError**
     */
    func getUserList(onComplete: @escaping () -> Void,
                     onFailure: @escaping (UsersAPI.NetworkError) -> Void) {

        let fetchRequestAllUsers: NSFetchRequest<UserCD> = UserCD.fetchRequest()
        fetchRequestAllUsers.sortDescriptors?.append(.init(key: #keyPath(UserCD.id), ascending: true))

        do {
            var usersFinded = try managedContext.fetch(fetchRequestAllUsers)
            usersFinded.sort { $0.id < $1.id }
            if usersFinded.count > 0 {
                let users = usersFinded.map { User(id: Int($0.id),
                                                   name: $0.name ?? "",
                                                   email: $0.email ?? "",
                                                   phone: $0.phone ?? "",
                                                   website: $0.website ?? "") }

                filteredUsers.append(contentsOf: users)
                self.users.append(contentsOf: filteredUsers)
                onComplete()
                return
            }
        } catch {
            onFailure(.unknownError)
        }

        connection.getUsersList { result in
            switch result {
            case .success(let users):
                if  users.count > 0 {

                    self.saveLocally(to: users, onFailure)

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
