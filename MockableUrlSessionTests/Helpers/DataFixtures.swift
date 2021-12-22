//
//  DataFixtures.swift
//  MockableUrlSessionTests
//
//  Created by Daniel Marcenco on 22.12.2021.
//

import Foundation

class DataFixtures {
    static var validUserListData: Data { return jsonData("users_fixture") }

    private static func jsonData(_ filename: String) -> Data {
        let path = Bundle(for: self).path(forResource: filename, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return jsonString.data(using: .utf8)!
    }
}
