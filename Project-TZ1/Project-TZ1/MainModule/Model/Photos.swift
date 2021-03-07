//
//  Model.swift
//  Project-TZ1
//
//  Created by Arslan Simba on 29.01.2021.
//

import Foundation

struct Photos: Codable {
    var id: Int
    var small_url: String
    var large_url: String
    var movie_url: String
    var is_locked: Bool
    var promotional_unlock: Bool
    var is_new: Bool
    var share_url: String
}
