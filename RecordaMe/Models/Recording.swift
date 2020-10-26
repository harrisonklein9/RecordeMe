//
//  Recording.swift
//  RecordaMe
//
//  Created by Harrison Klein on 10/24/20.
//

import UIKit

struct Recording: Codable, Identifiable {
    var location: URL
    var title: String
    var id: Int
}
