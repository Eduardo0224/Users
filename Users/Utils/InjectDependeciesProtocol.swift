//
//  InjectDependeciesProtocol.swift
//  Users
//
//  Created by Eduardo Andrade on 28/06/20.
//

import Foundation

protocol InjectDependenciesProtocol {
    func initiate<T>(with dependencies: [T])
}
