//
//  recordChirp.swift
//  socialBeacon
//
//  Created by Karim Elmaaroufi on 2/5/16.
//  Copyright © 2016 DreamCode. All rights reserved.
//

import Foundation
import AVFoundation

class recordAudio: AVAudioRecorder {
    var recordingSession: AVAudioSession!
    var clipRecorder: AVAudioRecorder!
    
    let recordingSettings: [String : AnyObject] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44100.0,
        AVNumberOfChannelsKey: 1 as NSNumber,
        AVEncoderAudioQualityKey: AVAudioQuality.Max.rawValue
    ]
    
    func load() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.loadRecordingUI()
                    }
                    else {
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
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getClipURL(recordingName : String) -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent(recordingName + ".m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    func startRecording(saveAudioDirectory: String?, duration: NSTimeInterval) {
        let audioURL: NSURL = recordAudio.getClipURL(saveAudioDirectory ?? recordAudio.getDocumentsDirectory() as String)
        do {
            clipRecorder = try AVAudioRecorder(URL: audioURL, settings: self.recordingSettings)
            // clipRecorder.delegate = channelView ? maybe self ?
            clipRecorder.recordForDuration(duration)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success success: Bool) {
        clipRecorder.stop()
        clipRecorder = nil
        
        /*
        if success {
        recordButton.setTitle("Tap to Re-record", forState: .Normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextTapped")
        } else {
        recordButton.setTitle("Tap to Record", forState: .Normal)
        
        let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        }
        */
    }
}
