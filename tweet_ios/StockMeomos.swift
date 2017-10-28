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
            "text": memo.text as AnyObject
        ]
        
        // HTTP通信
        Alamofire.request("http://localhost:3000/api/memos", method: .post, parameters: params).responseString(completionHandler: { response in
            print(request)
            print(response)
//            print(data)
//            print(error)
        })
//        Alamofire.request(.POST, "http://localhost:3000/api/memos", parameters: params).response{request, response, parameters, error in
//            
//            println("=============request=============")
//            println(request)
//            println("=============response============")
//            println(response)
//            println("=============JSON================")
//            println(JSON)
//            println("=============error===============")
//            println(error)
//            println("=================================")
//        }
        
    }
}
