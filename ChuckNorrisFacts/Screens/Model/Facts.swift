//
//  Fact.swift
//  ChuckNorrisFacts
//
//  Created by George de Araújo Apostolakis on 03/07/21.
//

import Foundation

struct Facts: Codable {
    var total = 0
    var result: [Fact]
}

struct Fact: Codable {
    let categories: [String]?
    let created_at: String?
    let icon_url: URL?
    let id: String?
    let update_at: String?
    let url: URL?
    let value: String?
}

