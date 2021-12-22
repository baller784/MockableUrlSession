//
//  NetworkManager.swift
//  MockableUrlSession
//
//  Created by Daniel Marcenco on 21.12.2021.
//

import Foundation

protocol NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(with urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: urlRequest) { (data, _, error) in
            completionHandler(data, error)
        }

        task.resume()
    }
}

class NetworkManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func makeRequest<T: Decodable>(
        with router: URLRequest,
        decode decodable: T.Type,
        completionHandler: @escaping (Result<T, Error>) -> Void
    ) {
        session.loadData(with: router) { data, error in
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }

            do {
                let jsonDecoder = JSONDecoder()
                let parsed = try jsonDecoder.decode(decodable, from: data)
                completionHandler(.success(parsed))
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
