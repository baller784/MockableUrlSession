//
//  User.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import Foundation

struct User: Codable {
    let gender: String
    let name: Name
    let email: String
    let phone, cell: String
    let picture: Picture
    let nat: String

    struct Name: Codable {
        let title, first, last: String
    }

    struct Picture: Codable {
        let large, medium, thumbnail: String
    }
}

extension User {
    struct NetworkResponse: Decodable {
        var results: [User]

        enum CodingKeys: String, CodingKey {
            case results
            case info
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            results = try container.decode([User].self, forKey: .results)
        }
    }
}
