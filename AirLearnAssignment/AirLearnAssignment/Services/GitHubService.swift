//
//  GitHubService.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import Combine
import Foundation

protocol GitHubServiceProtocol {
    func searchUsers(query: String, page: Int) -> AnyPublisher<[GitHubUser], APIError>
    func fetchUser(username: String) -> AnyPublisher<GitHubUser, APIError>
    func fetchFollowers(username: String) -> AnyPublisher<[GitHubUser], APIError>
    func fetchUserRepositories(username: String) -> AnyPublisher<[Repository], APIError>
}

class GitHubService: GitHubServiceProtocol {
    private let baseURL = "https://api.github.com"
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }

    
    func searchUsers(query: String, page: Int) -> AnyPublisher<[GitHubUser], APIError> {
        return networkManager.apiService(SearchUsersResponse.self, urlString: "\(baseURL)/search/users?q=\(query)&page=\(page)&per_page=20")
            .map{ $0.items }
            .eraseToAnyPublisher()
    }
    
    func fetchUser(username: String) -> AnyPublisher<GitHubUser, APIError> {
        return networkManager.apiService(GitHubUser.self, urlString: "\(baseURL)/users/\(username)")
            .eraseToAnyPublisher()
    }
    
    func fetchFollowers(username: String) -> AnyPublisher<[GitHubUser], APIError> {
        return networkManager.apiService([GitHubUser].self, urlString: "\(baseURL)/users/\(username)/followers")
            .eraseToAnyPublisher()
    }
    
    func fetchUserRepositories(username: String) -> AnyPublisher<[Repository], APIError> {
        return networkManager.apiService([Repository].self, urlString: "\(baseURL)/users/\(username)/repos")
            .eraseToAnyPublisher()
    }
}
