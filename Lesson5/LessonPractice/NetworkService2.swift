//
//  TestFile.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 20.04.2022.
//

import Foundation

struct ItemRequestParams: Codable {
    let index: Int
}
struct Item {
    var name: String
}

protocol NetworkClient {
    
    associatedtype Response
    
    typealias Completion = (Result<Response, Error>) -> ()
    
    func networkRequest<P: Codable>(params: P, completion: @escaping Completion)
}

final class NetworkService2<C: NetworkClient> {
    
    enum ServiceError: Error {
        case badResponse
    }
    
    typealias Completion = (Result<Item, Error>) -> ()
    typealias Parameters = [String: Int]
    
    private let client: C
    
    init(client: C) {
        self.client = client
    }
    
    
    func fetchItem(at index: Int, completion: @escaping Completion) {
        let params = ItemRequestParams(index: index)
        client.networkRequest(params: params) { result in
            switch result {
            case .success(let result):
                completion(.success(result as! Item))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

final class MockNetworkClient<R>: NetworkClient {

    enum MockNetworkClientError: Error {
        case stubError
    }

    typealias Response = R
    typealias Completion = (Result<Response, Error>) -> ()

    var stubError: Bool = false
    var stubResponse: R?
    func networkRequest<P: Codable>(params: P, completion: @escaping Completion) {
        guard let stubResponse = stubResponse else {
            completion(.failure(MockNetworkClientError.stubError))
            return
        }

        if stubError {
            completion(.failure(MockNetworkClientError.stubError))
        } else {
            completion(.success(stubResponse))
        }
    }
}
