//
//  UserRowView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserRowView: View {
    let user: GitHubUser
    
    var body: some View {
        HStack(spacing: 12) {
            if let url = URL(string: user.avatarURL) {
                WebImage(url: url) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.login)
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUser = GitHubUser(login: "A", id: 1410106, nodeID: "MDQ6VXNlcjE0MTAxMDY", avatarURL: "https://avatars.githubusercontent.com/u/1410106?v=4", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "https://api.github.com/users/A/repos", eventsURL: "", receivedEventsURL: "", type: .user, userViewType: .userViewTypePublic, siteAdmin: true)
        
        UserRowView(user: mockUser)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
