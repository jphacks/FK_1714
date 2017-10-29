//
//  StockMeomos.swift
//  tweet_ios
//
//  Created by 矢野大輝 on 2017/10/28.
//  Copyright © 2017年 矢野大輝. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class StockMemos: NSObject {
    
    // 保存ボタンが押されたときに呼ばれるメソッドを定義
    class func postMemo(memo: Memo) {
        
        var params: [String: AnyObject] = [
//            "text": memo.text as AnyObject
            "text": "ほげ" as AnyObject
//            print(speachLast)
        ]
        
        // HTTP通信
        Alamofire.request("http://localhost:3000/api/memos", method: .post, parameters: params).responseString(completionHandler: { response in
//            print(request)
//            print(response)
        })
        
        Alamofire.request("http://localhost:3000/show.json", method: .get).responseJSON(completionHandler: { response in
            print(response.value)
            var laala: Int!
            laala = 1
            if let laata = response.value{
//            if(response.result.value == 1){
                print("やったぜ")
            }
        })
        
    }
}
