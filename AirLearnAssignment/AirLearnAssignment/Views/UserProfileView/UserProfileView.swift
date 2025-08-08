//
//  UserProfileView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct UserProfileView: View {
    let user: GitHubUser
    @StateObject private var viewModel: UserProfileViewModel
    
    init(user: GitHubUser) {
        self.user = user
        _viewModel = StateObject(wrappedValue: UserProfileViewModel(user: user))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user.avatarURL)!)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 10)
            
            VStack(spacing: 8) {
                Text(user.login)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let bio = viewModel.user.bio {
                    Text(bio)
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                } else {
                    Text(Constant.PlainConstant.noBioAvailable)
                }
            }
            
            HStack(spacing: 30) {
                VStack {
                    Text("\(viewModel.followers)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(Constant.PlainConstant.followers)
                        .font(.caption)
                }
                
                NavigationLink(destination: RepositoriesListView(user: user, repositories: viewModel.repositories)) {
                    VStack {
                        Text("\(viewModel.repositories.count)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(Constant.PlainConstant.repositories)
                            .font(.caption)
                    }
                }
            }
            
            if let createdAt = viewModel.user.createdAt {
                Text("Joined \(formatDate(createdAt))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(user.login)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
}
