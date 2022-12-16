//
//  NetworkingManager.swift
//  Core
//
//  Created by Ken Wakabayashi on 10/12/22.
//

import Foundation

public enum NetworkingError: Error {
    case responseInvalidate
    case statusCodeError
}

public final class NetworkingManager {
        
    public enum HttpMethod: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    public init () {  }
    
    //<T> para variables genericas
    public func callService<T: Decodable> (url: String,
                                            method: HttpMethod,
                                            body: [String: Any]?,
                                            header: [String: String]) async -> Result<T, Error> {
        
        guard let url = URL.init(string: url) else { fatalError("url inválida") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let params = body {
            let data = try? JSONSerialization.data(withJSONObject: params)
            request.httpBody = data
        }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = header
        
        let session = URLSession.init(configuration: config)
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpURLResponse = response as? HTTPURLResponse else {
                return .failure(NetworkingError.responseInvalidate)
            }
            if httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300 {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                return .success(value)
            } else {
                return .failure(NetworkingError.statusCodeError)
            }
            
        } catch {
            return .failure(NetworkingError.responseInvalidate)
        }
    }
}
