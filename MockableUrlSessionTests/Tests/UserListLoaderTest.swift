//
//  UserListLoaderTest.swift
//  MockableUrlSessionTests
//
//  Created by Daniel Marcenco on 22.12.2021.
//

import XCTest
@testable import MockableUrlSession

class NetworkSessionMock: NetworkSession {
    private(set) var requestUrl: URL?

    var data: Data?
    var error: Error?

    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        requestUrl = urlRequest.url
        completionHandler(data, error)
    }
}

class UserListLoaderTest: XCTestCase {
    func testSuccessfullResponse() {
        let fixtureData = DataFixtures.validUserListData

        let networkSession = NetworkSessionMock()
        networkSession.data = fixtureData
        networkSession.error = nil

        let networkManager = NetworkManager(session: networkSession)

        var expectedResults: [User]?
        var expectedError: Error?

        UserListLoader.fetchUsers(
            manager: networkManager,
            completion: { response in
                switch response {
                case let .success(result):
                    expectedResults = result
                case let .failure(error):
                    expectedError = error
                }
            }
        )

        let expectedRequestUrl = URL(string: "https://randomuser.me/api/?results=5")

        XCTAssert(networkSession.requestUrl == expectedRequestUrl)
        XCTAssertNotNil(expectedResults)
        XCTAssertNil(expectedError)
    }
}
