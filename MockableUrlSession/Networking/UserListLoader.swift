//
//  UserListLoader.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import Foundation

struct UserListLoader {
    static func fetchUsers(
        manager: NetworkManager = NetworkManager(),
        completion: @escaping ([User]) -> Void
    ) {
        guard let url = URL(string: "https://randomuser.me/api/?results=5") else { return }

        manager.makeRequest(
            with: URLRequest(url: url),
            decode: User.NetworkResponse.self,
            completionHandler: { response in
                switch response {
                case let .success(result):
                    completion(result.results)
                case let .failure(error):
                    print(error)
                }
            }
        )
    }
}
