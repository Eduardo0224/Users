//
//  Post.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import Foundation

struct Post: Codable, Identifiable {
    // MARK: -  Properties
    let id, userId: Int
    let title, body: String
}
