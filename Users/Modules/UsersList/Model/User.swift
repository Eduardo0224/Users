//
//  User.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import Foundation

struct User: Codable, Identifiable {
    // MARK: -  Properties
    let id: Int
    let name, email, phone, website: String
}
