//
//  RepositoriesListView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct RepositoriesListView: View {
    @StateObject private var viewModel: UserProfileViewModel
    let user: GitHubUser
    let repositories: [Repository]
    
    init(user: GitHubUser, repositories: [Repository]) {
        self.user = user
        self.repositories = repositories
        _viewModel = StateObject(wrappedValue: UserProfileViewModel(user: user))
    }
    
    var body: some View {
        List {
            Text(Constant.PlainConstant.repositories)
                .font(.headline)
                .padding(.horizontal)
            if repositories.isEmpty {
                Text(Constant.PlainConstant.repositoriesNotFound)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(repositories) { repo in
                    RepositoryRowView(repository: repo)
                        .padding(.vertical, 4)
                }
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.fetchRepositories()
        }
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = GitHubUser(login: "A", id: 1410106, nodeID: "MDQ6VXNlcjE0MTAxMDY", avatarURL: "https://avatars.githubusercontent.com/u/1410106?v=4", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "https://api.github.com/users/A/repos", eventsURL: "", receivedEventsURL: "", type: .user, userViewType: .userViewTypePublic, siteAdmin: true)
        
        let mockRepositories = [
            Repository(id: 1002, name: "TestRepo", description: "Just a test repo", stargazersCount: 2, forksCount: 2, language: "Python")
        ]
        
        RepositoriesListView(user: mockUser, repositories: mockRepositories)
    }
}
