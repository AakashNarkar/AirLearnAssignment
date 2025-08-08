//
//  Repository.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}
