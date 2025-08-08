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
            Text("Repositories")
                .font(.headline)
                .padding(.horizontal)
            if repositories.isEmpty {
                Text("Repositories not found")
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
