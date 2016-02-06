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
    @IBOutlet var UploadBTN: UIButton!

    var recordingSession: AVAudioSession!
    var chirpRecorder: AVAudioRecorder!
    var chirpPlayer: AVAudioPlayer!
    var streamTitle: String?
    
    let audioURL = RecordViewController.getFileURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            // request recording permissions with the device
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
    
    // Set the chirp-label to indicate that we're ready to record
    func loadRecordingUI() {
        chirpLabel.text = "Ready to chirp"
    }
    
    // Indicate that we can't record with this device
    func loadFailUI() {
        chirpLabel.text = "An error has occurred :("
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Get the directory to be used for storing temporary files
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // Get the full path to be used for the 'chirp' temp file
    class func getFileURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("chirp.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    // Start the recording process
    func startRecording() {
        
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
    
    // Indicate that we're done recording (they can re-record now)
    func finishRecording(success success: Bool) {
        
        chirpRecorder = nil
        
        if success {
            chirpLabel.text = "Chirped"
            RecordBTN.setTitle("Tap to Re-record", forState: .Normal)
        } else {
            RecordBTN.setTitle("Tap to Record", forState: .Normal)
        }
    }
    
    // Invoked when we're done recording, goes to 'finishRecording', which will display 
    // the appropriate message to the user
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        } else {
            finishRecording(success: true)
        }
    }

    // Start the playback of the chirp (give them an opportunity to re-record)
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
    
    // Playback finished
    func finishPlayback(success success: Bool) {
        chirpPlayer = nil
        if success {
            PlaybackBTN.setTitle("Playback", forState: .Normal)
        } else {
            
        }
    }
    
    // Indicate that the audio-player is done playing, output a message to the user
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if !flag {
            finishPlayback(success: false)
        } else {
            finishPlayback(success: true)
        }
    }
    
    // Actual interface to the user (record, playback, upload)
    
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
    
    @IBAction func Upload(sender: UIButton) {
        ParseInterface.uploadParseSound(streamTitle!, recordingName: "chirp.m4a")
    }
}