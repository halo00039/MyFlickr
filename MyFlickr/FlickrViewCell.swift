//
//  FlickrViewCell.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class FlickrViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    var imageURL: URL?
}
