//
//  ViewController.swift
//  MyFlickr
//
//  Created by 葉上輔 on 2020/9/17.
//  Copyright © 2020 YehSF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var keyWord: UITextField!
    @IBOutlet weak var nums: UITextField!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }

   
    
}

extension ViewController: UITextFieldDelegate {
    
    func setupSubviews() {

        keyWord.delegate = self
        keyWord.placeholder = "Keyword"
        nums.placeholder = "Number of sheets (20)"
        nums.keyboardType = .numberPad
        
        searchBtn.isEnabled = false
        navigationItem.title = "Flickr"
    }
    
    @IBAction func searchHandler(_ sender: UIButton) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = false
        
        if let text = textField.text, let range = Range(range, in: text) {
            
            let newText = text.replacingCharacters(in: range, with: string)
            
            if newText.count < 16 {
                
               result = true
                
            }
            
            if newText.count > 0 {
                
                searchBtn.isEnabled = true
                
            } else {
                
                searchBtn.isEnabled = false
                
            }
        }
        
        return result
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let flickr = segue.destination as? FlickrViewController
  
        if let userInputKeyWord = keyWord.text, let userInputNums = nums.text {
            
            let newUserInputKeyWord = userInputKeyWord.trimmingCharacters(in: .whitespaces)
            print(newUserInputKeyWord)
            
            flickr?.userInputKeyWord = newUserInputKeyWord
            
            if userInputNums == "" {
                
            flickr?.userInputNums = "20"
                
            } else {
                
            flickr?.userInputNums = userInputNums
                
            }
        }
        
    }
}
