//
//  InitialViewController.swift
//  SpeechToText
//
//  Created by 宮崎一希 on 2017/10/29.
//  Copyright © 2017 imagepit. All rights reserved.
//

import UIKit
import Foundation

class InitialViewController: UIViewController{
    
    @IBOutlet weak var sleep: UIButton!
    @IBOutlet weak var meet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        saveImage()
//        initImageView()
    }
        
    private func initImageView(){
        // UIImage インスタンスの生成
        // 画像はAssetsに入れてないのとjpgなので拡張子を入れます
        let image:UIImage = UIImage(named:"byour")!
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image)
        
        // 画面の横幅を取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        // 画像の幅・高さの取得
        let imgWidth = image.size.width
        let imgHeight = image.size.height
        
        // 画像サイズをスクリーン幅に合わせる
        let scale = screenWidth / imgWidth * 0.9
        let rect:CGRect = CGRect(x:0, y:0, width:imgWidth*scale, height:imgHeight*scale)
        
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
        
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // 角丸にする
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.1
        imageView.clipsToBounds = true
        
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
