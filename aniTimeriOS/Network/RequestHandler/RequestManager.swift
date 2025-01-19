//
//  RequestManager.swift
//  aniTimeriOS
//
//  Created by João Gabriel Lavareda Ayres Barreto on 11/01/25.
//

import Foundation

class RequestManager {
    static let shared = RequestManager()
    
    private init() {}
    
    private let baseURL = "https://animeschedule.net/api/v3"
    private let token = "QNBoKZmEwQajGWuJPWcWrn26BHmKUG" // Replace with your actual token
    
    private func buildURL(endpoint: String, parameters: [String: Any]? = nil) -> URL? {
        var urlString = "\(baseURL)/\(endpoint)"
        
        if let parameters = parameters, !parameters.isEmpty {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                if let stringValue = value as? String {
                    queryItems.append(URLQueryItem(name: key, value: stringValue))
                }
            }
            
            var urlComponents = URLComponents(string: urlString)
            urlComponents?.queryItems = queryItems
            urlString = urlComponents?.url?.absoluteString ?? urlString
        }
        
        print("url string: \(urlString)")
        return URL(string: urlString)
    }
    
    private func makeRequest(endpoint: String, method: String = "GET", parameters: [String: Any]? = nil) -> URLRequest? {
        guard let url = buildURL(endpoint: endpoint, parameters: parameters) else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        print("Requesting URL: \(url)")
        
        // For GET requests, parameters should be part of the URL (query parameters), not the body
        if method != "GET", let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return request
    }
    
    func sendRequest<T: Decodable>(endpoint: String, method: String = "GET", parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = makeRequest(endpoint: endpoint, method: method, parameters: parameters) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
//            if let responseString = String(data: data, encoding: .utf8) {
//                       print("Raw Response: \(responseString)")
//                   }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case invalidRequest
    case noData
}
