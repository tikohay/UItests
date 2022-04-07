//
//  NetworkService.swift
//  Lesson5
//
//  Created by Karakhanyan Tigran on 06.04.2022.
//

import Foundation

class NetworkService {
    
    func getData(from urlString: String) -> Data? {
        guard let url = URL(string: urlString) else { return nil }
        var resultData: Data?
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                resultData = data
            }
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        
        return resultData
    }
    
    func parseFrom<T: Decodable>(data: Data, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let object = try decoder.decode(T.self, from: data)
            DispatchQueue.main.async {
                completion(.success(object))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
