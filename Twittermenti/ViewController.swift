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
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let tweetCount = 100
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "EEOH5KOZvoo4U94Ljqyy3Hre7", consumerSecret: "AlRY6A6qVAVGe4YhLXu0olKbucg6kFIvM9Tc5owsmd2C7khyL8")

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: Any) {
        
        fetchTweets()
    
    }
    
    func fetchTweets() {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended) { [self] (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<tweetCount {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                makePrediction(with: tweets)
                
            } failure: { (error) in
                print("There was an error with the Twitter API Request, \(error)")
            }
            
            
        }
        
    }
    
    func makePrediction(with tweets: [TweetSentimentClassifierInput]) {
        
        do {
            
            let predictions = try sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            for pred in predictions {
                let sentiment = pred.label
                if sentiment == "Pos" {
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    sentimentScore -= 1
                }
            }
            
            updateUI(with: sentimentScore)
            
        } catch {
            print("There was an error with making a prediciton, \(error)")
        }
        
    }
    
    func updateUI(with sentimentScore: Int) {
        
        if sentimentScore > 20 {
            sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            sentimentLabel.text = "😀"
        } else if sentimentScore > 0 {
            sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            sentimentLabel.text = "☹️"
        } else if sentimentScore > -20 {
            sentimentLabel.text = "😡"
        } else {
            sentimentLabel.text = "🤬"
        }
        
    }
    
}

