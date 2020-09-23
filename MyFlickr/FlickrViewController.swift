//
//  FlickrViewController.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FlickrViewCell"

class FlickrViewController: UICollectionViewController {
    
    var userInputKeyWord = ""
    var userInputNums = ""
    var photos = [PhotoInfo]() {
        didSet {
            
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
                self.navigationItem.title = "\(self.photos.count) images found"

            }
        }
    }
    
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        fetchData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource




    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FlickrViewCell
        
        let photo = photos[indexPath.item]
        cell.title.text = photo.title
        print(photo.title)
        cell.imageURL = photo.imageURL
        print(photo.imageURL)
        cell.imageView.image = nil
        NetworkUtility.downloadImage(url: cell.imageURL!) { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let image):
                DispatchQueue.main.async {
                    
                    cell.imageView.image = image
                    
                }
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension FlickrViewController {
    
    func setupSubviews() {
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (view.bounds.width - 10) / 2
        layout?.itemSize = CGSize(width: width, height: width + 30)
        layout?.estimatedItemSize = .zero
        layout?.minimumInteritemSpacing = 1
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        

        
    }
    
    func fetchData() {

        let flickrRequest = FlickrRequest(userInput: userInputKeyWord, nums: userInputNums)
        flickrRequest.fetchData { [weak self] result in
        
            switch result {
                
            case .failure(let err):
                print(err)
                
            case .success(let photos):
                self?.photos = photos
                
            }
        
        }
        
    }
    
    @IBAction func unwindToFlickr(_ sender: UIStoryboardSegue) {
        
    }
    

}
