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
    
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath as IndexPath)
        
        let tweet = tweets[indexPath.row]
        cell.textLabel?.text = tweet.title
        
        return cell
    }
}
