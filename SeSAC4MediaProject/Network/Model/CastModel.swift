//
//  CastModel.swift
//  SeSAC4MediaProject
//
//  Created by Minho on 1/31/24.
//

import Foundation

// MARK: - CastModel
struct CastModel: Codable {
    let cast, crew: [Cast]
    let id: Int
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let roles: [Role]?
    let totalEpisodeCount: Int
    let order: Int?
    let jobs: [Job]?
    let department: Department?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case roles
        case totalEpisodeCount = "total_episode_count"
        case order, jobs, department
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case creator = "Creator"
    case directing = "Directing"
    case writing = "Writing"
}

// MARK: - Job
struct Job: Codable {
    let creditID, job: String
    let episodeCount: Int

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case job
        case episodeCount = "episode_count"
    }
}

// MARK: - Role
struct Role: Codable {
    let creditID, character: String
    let episodeCount: Int

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case character
        case episodeCount = "episode_count"
    }
}
