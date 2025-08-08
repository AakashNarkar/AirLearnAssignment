//
//  RepositoryRowView.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(repository.name)
                    .font(.headline)
                
                Spacer()
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: Constant.ImageConstant.starfill)
                            .foregroundColor(.yellow)
                        Text("\(repository.stargazersCount)")
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: Constant.ImageConstant.arrowBranch)
                        Text("\(repository.forksCount)")
                    }
                }
                .font(.caption)
            }
            
            if let description = repository.description {
                Text(description)
                    .font(.subheadline)
                    .lineLimit(2)
            }
            
            if let language = repository.language {
                HStack {
                    Circle()
                        .fill(languageColor(language))
                        .frame(width: 10, height: 10)
                    Text(language)
                        .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    private func languageColor(_ language: String) -> Color {
        switch language.lowercased() {
        case "swift": return .orange
        case "python": return .blue
        case "javascript": return .yellow
        case "java": return .red
        case "c++": return .pink
        case "ruby": return .red
        case "go": return .cyan
        case "typescript": return .blue
        case "php": return .purple
        case "c#": return .green
        default: return .gray
        }
    }
}


struct RepositoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRepository = Repository(id: 1002, name: "TestRepo", description: "Just a test repo", stargazersCount: 2, forksCount: 2, language: "Python")
        
        RepositoryRowView(repository: mockRepository)
            .previewLayout(.sizeThatFits)
    }
}
