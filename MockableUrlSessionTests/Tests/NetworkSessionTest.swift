//
//  NetworkSessionTest.swift
//  MockableUrlSessionTests
//
//  Created by Daniel Marcenco on 22.12.2021.
//

import XCTest
@testable import MockableUrlSession

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}

class NetworkManagerTest: XCTestCase {
    func testSuccessfullResponse() {
        let fixtureData = DataFixtures.validUserListData

        let networkSession = NetworkSessionMock()
        networkSession.data = fixtureData
        networkSession.error = nil

        let networkManager = NetworkManager(session: networkSession)

        var expectedResults: [User]?
        var expectedError: Error?

        networkManager.makeRequest(
            with: URLRequest(url: URL(string: "https://randomuser.me/api/?results=5")!),
            decode: User.NetworkResponse.self,
            completionHandler: { response in
                switch response {
                case let .success(result):
                    expectedResults = result.results
                case let .failure(error):
                    expectedError = error
                }
            }
        )

        XCTAssertNotNil(expectedResults)
        XCTAssertNil(expectedError)
    }
}
