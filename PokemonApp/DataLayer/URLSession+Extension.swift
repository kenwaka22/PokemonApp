//
//  URLSession+Extension.swift
//  UICollectionView-UIKit
//
//  Created by Ken Wakabayashi on 7/01/23.
//

import Foundation

extension URLSession {
    enum CustomError: Error {
        case invaidURL
        case invalidData
    }
    
    func request<T: Codable> (urlString: String, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(CustomError.invaidURL))
            return
        }
        
        let task = dataTask(with: url)  { data, urlResponse, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(model, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
