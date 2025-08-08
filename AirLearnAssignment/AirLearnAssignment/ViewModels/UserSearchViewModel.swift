//
//  UserSearchViewModel.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import Combine
import Foundation

class UserSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var users: [GitHubUser] = []
    @Published var isLoading = false
    @Published var error: APIError?
    
    private var cancellables = Set<AnyCancellable>()
    private let githubService: GitHubServiceProtocol
    var page = 1
    
    init(githubService: GitHubServiceProtocol = GitHubService()) {
        self.githubService = githubService
        
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                self?.resetSearch()
                self?.searchUsers(query: query)
            }
            .store(in: &cancellables)
    }
    
    func searchUsers(query: String) {
        isLoading = true
        error = nil
        
        githubService.searchUsers(query: query, page: page)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error
                }
            } receiveValue: { [weak self] users in
                self?.users.append(contentsOf: users)
                self?.page += 1
            }
            .store(in: &cancellables)
    }
    
    func resetSearch() {
        self.page = 1
        self.users = []
        self.isLoading = false
        self.error = nil
    }
}
