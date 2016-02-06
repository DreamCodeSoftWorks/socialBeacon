//
//  ViewController.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import AVFoundation


class RecordViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet var chirpLabel: UILabel!
    @IBOutlet var RecordBTN: UIButton!
    @IBOutlet var PlaybackBTN: UIButton!
    @IBOutlet var ProgressBar: UIProgressView!
    
    var recordingSession: AVAudioSession!
    var chirpRecorder: AVAudioRecorder!
    var chirpPlayer: AVAudioPlayer!
    
    let audioURL = RecordViewController.getFileURL()
    
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
            chirpRecorder.recordForDuration(6.0)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success success: Bool) {
        
        chirpRecorder = nil
        
        if success {
            chirpLabel.text = "Chirped"
            RecordBTN.setTitle("Tap to Re-record", forState: .Normal)
            ParseInterface.uploadParseSound("Party Channel", recordingName: "chirp.m4a")
        } else {
            RecordBTN.setTitle("Tap to Record", forState: .Normal)
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        } else {
            finishRecording(success: true)
        }
    }

    func startPlayback() {
        do {
            chirpPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
            chirpPlayer.delegate = self
            chirpPlayer.volume = 1.0
            chirpPlayer.play()
        } catch {
            finishPlayback(success: false)
        }
    }
    
    func finishPlayback(success success: Bool) {
        chirpPlayer = nil
        if success {
            PlaybackBTN.setTitle("Playback", forState: .Normal)
        } else {
            
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if !flag {
            finishPlayback(success: false)
        } else {
            finishPlayback(success: true)
        }
    }
    
    @IBAction func Record(sender: UIButton) {
        if chirpRecorder == nil {
            startRecording()
        } else {
            chirpRecorder.stop()
        }
    }
    
    @IBAction func Playback(sender: UIButton) {
        if chirpPlayer == nil {
            startPlayback()
        }
    }
}