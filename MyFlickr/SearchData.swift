//
//  SearchData.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

struct Photos: Codable {
    let photos: [Photo]
}

struct Photo: Codable {
    let photo: [PhotoInfo]
}

struct PhotoInfo: Codable {
    var id: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var imageURL: URL {
        return URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

