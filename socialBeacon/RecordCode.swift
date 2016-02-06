//
//  RecordCode.swift
//  socialBeacon
//
//  Created by Arjun Hans on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class RecordCode: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    /*override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRecoder() {
        let recordSettings : [String : AnyObject] = [AVFormatIDKey: Int(kAudioFormatAppleLossless),
            AVEncoderAudioQualityKey: AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0
        ];
        
        NSLog("setupRecorder")
        do {
            try SoundRecorder = AVAudioRecorder(URL: getFileURL(), settings: recordSettings)
        } catch {
            NSLog("Something is Wrong")
        }
        
        SoundRecorder.delegate = self
        SoundRecorder.prepareToRecord()
    }
    
    func getCacheDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0]
    }
    
    func getFileURL() -> NSURL {
        let path = getCacheDirectory().stringByAppendingString(fileName)
        NSLog(path)
        let filePath = NSURL(fileURLWithPath: path)
        return filePath
    }
    
    func Record(sender: UIButton) {
        if sender.titleLabel?.text == "Record" {
            SoundRecorder.record()
            sender.setTitle("Stop", forState: .Normal)
            PlayBTN.enabled = false
        } else {
            SoundRecorder.stop()
            sender.setTitle("Record", forState: .Normal)
            PlayBTN.enabled = false
            
        }
    }
    
    func PlaySound(sender: UIButton) {
        if sender.titleLabel?.text == "Play" {
            RecordBTN.enabled = false
            sender.setTitle("Stop", forState: .Normal)
            preparePlayer()
            NSLog("Play sound")
            SoundPlayer.play()
        } else {
            
            SoundPlayer.stop()
            sender.setTitle("Play", forState: .Normal)
        }
    }
    
    func preparePlayer() {
        NSLog("PreparePlayer")
        do {
            try SoundPlayer = AVAudioPlayer(contentsOfURL: getFileURL())
            SoundPlayer.delegate = self
            SoundPlayer.prepareToPlay()
            SoundPlayer.volume = 1.0
        } catch {
            NSLog("Something is Wrong")
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        PlayBTN.enabled = true
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        RecordBTN.enabled = true
        PlayBTN.setTitle("Play", forState:  .Normal)
    }

*/
}