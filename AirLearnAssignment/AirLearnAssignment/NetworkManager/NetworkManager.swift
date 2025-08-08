//
//  NetworkManager.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case invalidURL
    case userNotFound
    case invalidResponse
    case invalidData
    case decodingFailed
    case serverError(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .userNotFound: return "User not found"
        case .invalidResponse: return "Invalid response from server"
        case .invalidData: return "Invalid data received"
        case .decodingFailed: return "Failed to decode"
        case .serverError(let message): return message
        case .unknown(let error): return error.localizedDescription
        }
    }
}

// MARK: - NetworkManagerProtocol
protocol NetworkManagerProtocol {
    func apiService<T: Codable>(_ type: T.Type, urlString: String) -> AnyPublisher<T, APIError>
}

// MARK: - NetworkManager
class NetworkManager: NetworkManagerProtocol {
    
    func apiService<T: Codable>(_ type: T.Type, urlString: String) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: .invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .map { data in
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return .decodingFailed
                }
                if let error = error as? APIError {
                    return error
                }
                return .invalidResponse
            }
            .eraseToAnyPublisher()
    }
}
