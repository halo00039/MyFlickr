//
//  NetworkUtility.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

enum ImageError: Error {
    
    case noImageError
    case cantprocessImage
    
}


struct NetworkUtility {
    static func downloadImage(url: URL, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let _data = data else {
                completion(.failure(.noImageError))
                return
            }
            
            if let image = UIImage(data: _data) {
                
                completion(.success(image))
                
            } else {
                
                completion(.failure(.cantprocessImage))
                
            }
            
        }
        task.resume()
    }
}

