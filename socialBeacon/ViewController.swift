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
    
    @IBOutlet var chirpLabel: UILabel!
    @IBOutlet var RecordBTN: UIButton!
    
    var recordingSession: AVAudioSession!
    var chirpRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        chirpLabel.text = "Ready to chirp"
    }
    
    func loadFailUI() {
        chirpLabel.text = "An error has occurred :("
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getFileURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("chirp.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    func startRecording() {
        
        let audioURL = ViewController.getFileURL()
        print(audioURL.absoluteString)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        RecordBTN.setTitle("Stop", forState: .Normal)
        
        do {
            chirpRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            chirpRecorder.delegate = self
            chirpRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success success: Bool) {
        chirpRecorder.stop()
        chirpRecorder = nil
        
        if success {
            RecordBTN.setTitle("Tap to Re-record", forState: .Normal)
        } else {
            RecordBTN.setTitle("Tap to Record", forState: .Normal)
        }
    }
    
    func RecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }

    @IBAction func Record(sender: UIButton) {
        if chirpRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
}