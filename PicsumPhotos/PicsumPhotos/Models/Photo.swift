//
//  Photo.swift
//  PicsumPhotos
//
//  Created by Abhishek Shukla on 02/02/24.
//

import Foundation

struct Photo: Codable {
    let id: String
    let author: String
    let width: Double
    let height: Double
    let url: String
    let download_url: String
}
