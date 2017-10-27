//
//  TweetsViewController.swift
//  tweet_ios
//
//  Created by 矢野大輝 on 2017/10/22.
//  Copyright © 2017年 矢野大輝. All rights reserved.
//

import Foundation
import UIKit

class TweetsViewController: UITableViewController {
    
    // ダミーデータ
    private var tweets:[Tweet] = [Tweet(title: "hoge", body: "hogehoge"),
                                  Tweet(title: "foo", body: "fooooo"),
                                  Tweet(title: "bar", body: "barbar")]
    
    override func viewDidLoad() {
        print(tweets.count)
    
    }
    
    func numberOfSectionsInTableView(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let tweet = tweets[indexPath.row]
        cell.textLabel?.text = tweet.title
        
        return cell
    }
}
