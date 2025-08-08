//
//  UserSearchView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct UserSearchView: View {
    @StateObject private var viewModel = UserSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText, placeholder: Constant.PlainConstant.searchUser)
                
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView()
                        .padding()
                } else if let error = viewModel.error {
                    ErrorView(error: error)
                } else if viewModel.users.isEmpty && !viewModel.searchText.isEmpty && !viewModel.isLoading {
                    Text(Constant.PlainConstant.userNotFound)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: UserProfileView(user: user)) {
                                UserRowView(user: user)
                                    .onAppear {
                                        if user.id == viewModel.users.last?.id && !viewModel.isLoading {
                                            viewModel.searchUsers(query: viewModel.searchText)
                                        }
                                    }
                            }
                        }
                        
                        if viewModel.isLoading && !viewModel.users.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                Spacer()
            }
            .navigationTitle(Constant.PlainConstant.gitHubUsers)
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue.isEmpty {
                    self.viewModel.resetSearch()
                }
            }
        }
    }
}
