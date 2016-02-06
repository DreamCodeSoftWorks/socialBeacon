//
//  ViewController.swift
//  socialBeacon
//
//  Created by Arjun Hans on 2/5/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    @IBOutlet var RecordBTN: UIButton!
    @IBOutlet var PlayBTN: UIButton!
    @IBOutlet var filelabel: UIButton!

    
    var soundRecorder: AVAudioRecorder!
    var recordingSession: AVAudioSession!
    
    var fileName = "audioFile.m4a"
    
    let recordSettings =
    [
        AVFormatIDKey : Int(kAudioFormatMPEGLayer3),
        AVEncoderBitRateKey: 320000 as NSNumber,
        AVNumberOfChannelsKey: 1 as NSNumber,
        AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue as NSNumber,
        AVSampleRateKey: 44100.0 as NSNumber,
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayBTN.enabled = false
        // Do any additional setup after loading the view, typically from a nib.
        setupRecorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func setupRecorder(){
        recordingSession = AVAudioSession.sharedInstance()
    
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }

    func loadRecordingUI() {
    
    }

    func loadFailUI() {
    
    }
    
    @IBAction func Record(sender: UIButton) {
        
        if sender.titleLabel?.text == "Record"{
            
            startRecording("Downloads", duration: 10.0)
            PlayBTN.enabled = false
            sender.setTitle("Stop", forState: .Normal)
            
        } else {
            if soundRecorder?.recording == true {
                soundRecorder?.stop()
            }
            sender.setTitle("Record", forState: .Normal)
            
        }
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DownloadsDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        
        print("documentsDirectory")
        return documentsDirectory
    }
    
    func getClipURL(recordingName : String) -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent(recordingName + ".m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        return audioURL
    }
    
    func startRecording(saveAudioDirectory: String?, duration: NSTimeInterval) {
        let audioURL: NSURL = recordAudio.getClipURL("recording")
        filelabel.setTitle(audioURL.absoluteString, forState: .Normal)

        do {
            soundRecorder = try AVAudioRecorder(URL: audioURL, settings: self.recordSettings)
            soundRecorder.delegate = self
            soundRecorder.record()
        } catch {

        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        //hello
    }
}