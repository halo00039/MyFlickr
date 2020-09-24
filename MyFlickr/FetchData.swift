//
//  FetchData.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

struct FetchData {
    
    let resourceURL: URL
    
    let API_KEY = "614b7591153243d4b59c0a9d4fc10dd3"
    
    init(userInput: String, nums: Int) {
        
    let resourceStr = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEY)&text=\(userInput)&per_page=\(nums)&format=json&nojsoncallback=1"
        
        guard let resourceURL = URL(string: resourceStr) else { fatalError() }
        self.resourceURL = resourceURL
    }
}
