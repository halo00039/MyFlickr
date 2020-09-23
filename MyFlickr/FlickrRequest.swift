//
//  FlickrRequest.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import Foundation

enum FlickrError: Error {
    
    case noDataAvailable
    case cantprocessData
    
}


struct FlickrRequest {
    
    let resourceURL: URL
    
    let API_KEY = "dbb0ceceec00c13d18315a23fb275419"
    
    init(userInput: String, nums: String) {
        
    let resourceStr = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(API_KEY)&text=\(userInput)&per_page=\(nums)&format=json&nojsoncallback=1"
        
        
        guard let resourceURL = URL(string: resourceStr) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func fetchData(completion: @escaping (Result<[PhotoInfo],FlickrError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: resourceURL) { (data, _, _) in
            
            guard let jsonData = data else {
                
                completion(.failure(.noDataAvailable))
                
                return
                
            }
            
            do {
                
                let photos = try JSONDecoder().decode(Photos.self, from: jsonData)
                let photoInfo = photos.photos.photo
                completion(.success(photoInfo))
                
            } catch {
                
                completion(.failure(.cantprocessData))
                
            }
            
        }
        
        task.resume()
        
    }
    
}
