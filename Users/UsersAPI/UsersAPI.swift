//
//  UsersAPI.swift
//  Users
//
//  Created by Eduardo Andrade on 27/06/20.
//

import Foundation

typealias ResultConnection<RequestType> = Result<RequestType, UsersAPI.NetworkError>

class UsersAPI {

    // MARK: - Enums

    /**
     ## Manages the path component to complete URL.
     Makes use of associated values for such purpose
     */
    enum Endpoints {
        static let base = "https://jsonplaceholder.typicode.com"

        case getUsers
        case getPosts(Int)

        var stringURL: String {
            switch self {
            case .getUsers:
                return "\(Endpoints.base)/users"
            case .getPosts(let userId):
                return "\(Endpoints.base)/posts?userId=\(userId)"
            }
        }

        var url: URL? { URL(string: stringURL) }
    }

    /// Network Error
    enum NetworkError: Error {
        case urlNilError
        case requestError(String?)
        case internalServerError
        case decodeError(String)
        case unknownError
    }

    /// HTTP Status Code
    private enum HTTPStatusCode: Int, Error {
        case ok = 200
        case notFound = 400
        case serverError = 500
        case unknown

        init(code: Int) {
            switch code {
                case 200...299: self = .ok
                case 400...499: self = .notFound
                case 500...599: self = .serverError
                default: self = .unknown
            }
        }
    }

    // MARK: - Functions
    @discardableResult class func taskForGETRequest<RequestType: Decodable>(in url: URL,
                                                                            response: RequestType.Type,
                                                                            completion: @escaping (ResultConnection<RequestType>) -> Void) -> URLSessionTask {
        let dataTask = URLSession.shared.dataTask(with: url) { data, urlResponse, requestError in
            if let error = requestError {
                failureResponseHandler(with: .requestError(error.localizedDescription), in: completion); return
            } else {
                guard let data = data else {
                    failureResponseHandler(with: .requestError(nil), in: completion); return
                }

                switch HTTPStatusCode(code: (urlResponse as? HTTPURLResponse)?.statusCode ?? 0) {
                    case .ok:
                        let decoder = JSONDecoder()
                        do {
                            let responseDecoded = try decoder.decode(RequestType.self, from: data)
                            callInMainThread { completion(.success(responseDecoded)) }
                        } catch (let error) {
                            failureResponseHandler(with: .decodeError(error.localizedDescription), in: completion)
                        }
                    case .notFound:
                        failureResponseHandler(with: .requestError(nil), in: completion)
                    case .serverError:
                        failureResponseHandler(with: .internalServerError, in: completion)
                    case .unknown:
                        failureResponseHandler(with: .unknownError, in: completion)
                }
            }
        }
        dataTask.resume()
        return dataTask
    }

    private class func failureResponseHandler<RequestType>(with error: UsersAPI.NetworkError, in completion: @escaping (ResultConnection<RequestType>) -> Void) {
        callInMainThread { completion(.failure(error)) }
    }

    private class func callInMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
