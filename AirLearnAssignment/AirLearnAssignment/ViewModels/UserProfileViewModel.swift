//
//  UserProfileViewModel.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import Combine
import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var user: GitHubUser
    @Published var isLoading = false
    @Published var error: APIError?
    @Published var followers: Int = 0
    @Published var repositories: [Repository] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let githubService: GitHubServiceProtocol
    
    init(user: GitHubUser, githubService: GitHubServiceProtocol = GitHubService()) {
        self.user = user
        self.githubService = githubService
        self.loadDataAsync()
    }
    
    func fetchUser() {
        githubService.fetchUser(username: user.login)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
    
    func fetchUserFollowers() {
        githubService.fetchFollowers(username: user.login)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] users in
                self?.followers = users.count
            }
            .store(in: &cancellables)
    }
    
    func fetchRepositories() {
        githubService.fetchUserRepositories(username: user.login)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] repositories in
                self?.repositories = repositories
            }
            .store(in: &cancellables)
    }
    
    func loadDataAsync() {
        isLoading = true
        error = nil

        let userPublisher = githubService.fetchUser(username: user.login)
        let followersPublisher = githubService.fetchFollowers(username: user.login)
        let reposPublisher = githubService.fetchUserRepositories(username: user.login)

        Publishers.Zip3(userPublisher, followersPublisher, reposPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let err) = completion {
                    self?.error = err
                }
            } receiveValue: { [weak self] user, followers, repositories in
                self?.user = user
                self?.followers = followers.count
                self?.repositories = repositories
            }
            .store(in: &cancellables)
    }
}
