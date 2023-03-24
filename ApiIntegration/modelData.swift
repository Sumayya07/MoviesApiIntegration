//
//  modelData.swift
//  ApiIntegration
//
//  Created by Sumayya Siddiqui on 23/03/23.
//

import Foundation

// MARK: - Task
struct Task: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
