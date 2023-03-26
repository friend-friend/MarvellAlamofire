//
//  Character.swift
//  MarvellAlamofire
//
//  Created by Вячеслав Онучин on 19.03.2023.
//

import Foundation

struct MarvellAnswer: Codable {
    let data: Characters?
}

struct Characters: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int?
    let name, description: String?
    let thumbnail: Image?
    let comics: Comics?
}

struct Comics: Codable {
    let available: Int
    let items: [ComicsItem]
}

struct ComicsItem: Codable {
    let name: String
}

struct Image: Codable {
    let path: String?
    let format: String?

    enum CodingKeys: String, CodingKey {
        case path
        case format = "extension"
    }
}
