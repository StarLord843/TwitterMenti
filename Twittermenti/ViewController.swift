//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "EEOH5KOZvoo4U94Ljqyy3Hre7", consumerSecret: "AlRY6A6qVAVGe4YhLXu0olKbucg6kFIvM9Tc5owsmd2C7khyL8")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
            
            
            
        } failure: { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }

        
        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

