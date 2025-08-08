//
//  UserRowView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct UserRowView: View {
    let user: GitHubUser
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: user.avatarURL)!)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.login)
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
