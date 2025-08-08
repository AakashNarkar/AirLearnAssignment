//
//  GitHubUser.swift
//  AirLearnAssignment
//
//  Created by Aakash Narkar on 08/08/25.
//

// MARK: - SearchUsersResponse
struct SearchUsersResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [GitHubUser]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - GitHubUser
struct GitHubUser: Codable, Identifiable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url, htmlURL, followersURL: String
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: TypeEnum
    let userViewType: UserViewType
    let siteAdmin: Bool
    var bio: String?
    var createdAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
        case bio
        case createdAt = "created_at"
    }
}

enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}

enum UserViewType: String, Codable {
    case userViewTypePublic = "public"
}

