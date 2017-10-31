//
//  ViewController.swift
//  SpeechToText
//
//  Created by imagepit on 2016/09/30.
//  Copyright © 2016年 imagepit. All rights reserved.
//

import UIKit
import Speech

//@available(swift, obsoleted:3.1)
class ViewController: UIViewController {

    // 音声認識
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var recognitionResult: SFSpeechRecognitionResult?
    //private var inputNode:AVAudioInputNode?
    
    var speachLast :String = ""
    
    // View
    let textView = UITextView()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 音声認識初期化
        speechRecognizer.delegate = self
        self.requestRecognizerAuthorization()
        
        viewInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "onegai" { //SecondViewControllerに遷移する場合
            // SecondViewControllerをインスタンス化
            let secondVc = segue.destination as! TweetsViewController
            // 値を渡す
            secondVc.speachLast = self.speachLast
            
            //        }else if segue.identifier == "goThird" { //ThirdViewControllerに遷移する場合
            //            // ThirdViewControllerをインスタンス化
            //            let thirdVc = segue.destinationViewController as! ThirdViewController
            //            // 値を渡す
            //            thirdVc.b = self.b
            //
            //        }else {
            //            // どちらでもない遷移
        }
    }
    
    //--------------------------------
    // MARK: - View Init
    //--------------------------------
    private func viewInit(){
        // TextView表示
        textView.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        textView.center = self.view.center
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 5
        self.view.addSubview(textView)
        // Button表示
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 45)
        button.center = CGPoint(x: self.view.center.x, y: self.view.center.y+140)
        button.setTitle("夢の中へ", for: .normal)
        button.backgroundColor = UIColor.red
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(self, action: #selector(ViewController.buttonTapped), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    //--------------------------------
    // MARK: - Action
    //--------------------------------
    func buttonTapped(){
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            button.isEnabled = false
            button.setTitle("夢の中へ", for: .normal)
//            print("#### 停止 ####")
        } else {
            try! startRecording()
            button.setTitle("起きる", for: .normal)
//            print("#### スタート ####")
        }
    }

    //--------------------------------
    // MARK: - 音声認識
    //--------------------------------
    // 認証処理
    private func requestRecognizerAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // メインスレッドで処理したい内容のため、OperationQueue.main.addOperationを使う
            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self else { return }
                switch authStatus {
                case .authorized:
                    self.textView.text = "音声認識へのアクセスが許可されています。"
                case .denied:
                    self.textView.text = "音声認識へのアクセスが拒否されています。"
                case .restricted:
                    self.textView.text = "音声認識へのアクセスが制限されています。"
                case .notDetermined:
                    self.textView.text = "音声認識はまだ許可されていません。"
                }
            }
        }
    }
    // 録音開始
    private func startRecording() throws {
        refreshTask()
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }

        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let `self` = self else { return }
            
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
                self.speachLast = result.bestTranscription.formattedString
            }
            
            if error != nil || isFinal {
//                print("error:\(String(describing: error))")
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.button.isEnabled = true
                self.textView.text = "音声認識スタート"
            }
        }
        
        // マイクから取得した音声バッファをリクエストに渡す
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }
    
    private func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }
    
    private func startAudioEngine() throws {
        // startの前にリソースを確保しておく。
        audioEngine.prepare()
        try audioEngine.start()
        button.setTitle("音声認識停止", for: .normal)
        print("#### 音声認識停止 ####")
    }
    
}

extension ViewController: SFSpeechRecognizerDelegate {
    // 音声認識の可否が変更したときに呼ばれるdelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            button.isEnabled = true
            button.setTitle("夢の中へ", for: .normal)
            print("#### 音声認識スタート ####")
        } else {
            button.isEnabled = false
            button.setTitle("起きる", for: .normal)
            print("#### 音声認識ストップ ####")
        }
    }
}
