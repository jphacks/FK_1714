//
//  TweetDetailViewController.swift
//  tweet_ios
//
//  Created by 矢野大輝 on 2017/10/27.
//  Copyright © 2017年 矢野大輝. All rights reserved.
//

import Foundation
import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet?
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = self.tweet {
            print(tweet.title)
            print(tweet.body)
            
            titleTextLabel.text? = tweet.title
            bodyTextLabel.text? = tweet.body
        }
    }
}
