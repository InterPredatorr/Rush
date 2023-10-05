//
//  NetworkManager.swift
//  Rush
//
//  Created by Aziz on 27.07.23.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum UserResponseType: Int {
    case valid = 1
    case invalid = 2
}

struct LoginResponse: Codable {
    let result: LoginResponse.Result
    
    struct Result: Codable {
        let resultCode: Int
    }
}

class NetworkManager {
    
    func makeLoginRequest(with url: URL, parameters: [String: Any], completion: @escaping (Result<UserResponseType, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.post.rawValue
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            completion(.failure(error))
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.rush", code: -1, userInfo: nil)))
                return
            }
            do {
                let result = try JSONDecoder().decode(LoginResponse.self, from: data)
                if let type = UserResponseType(rawValue: result.result.resultCode) {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
