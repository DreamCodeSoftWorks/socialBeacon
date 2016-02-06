//
//  ViewController.swift
//  socialBeacon
//
//  Created by Arjun Hans on 2/5/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    @IBOutlet var RecordBTN: UIButton!
    @IBOutlet var PlayBTN: UIButton!
    
    var audioPlayer: AVPlayer!

    var SoundRecorder : AVAudioRecorder!
    var SoundPlayer : AVAudioPlayer!
    var fileName = "audiofile"
    
    func uploadParseChannel(channelName : String) {
        let channelParseObj = PFObject(className: channelName)
        channelParseObj["name"] = channelName
        channelParseObj.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("Uploaded channel: \(channelName)")
            } else {
                print("Failed to upload channel: \(channelName)")
            }
        }
    }
    
    /*func downloadAllChannels() {
        let query = PFQuery(className: "channels")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    
                }
            }
        
    }*/
    
    func uploadParseSound(channelName : String, recordingName : String) {
        let soundPath = NSBundle.mainBundle().pathForResource(recordingName, ofType: nil)
        let soundParseFile = PFFile(name: "song.mp3", data: NSData(contentsOfURL: NSURL(fileURLWithPath: soundPath!))!)
        let soundParseObj = PFObject(className: "channelSound")
        
        
        soundParseObj["channelName"] = channelName
        soundParseObj["sound"] = soundParseFile

        
        soundParseObj.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                print("Uploaded channel sound")
            } else {
                print("Failed to upload channel sound")
            }
        }
    }
        
    func downloadChannelSounds(channelName : String) {
        let query = PFQuery(className: "channelSound")
        query.whereKey("channelName", equalTo: channelName)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    self.play(object)
                }
            } else {
                NSLog("Error, couldn't load sounds")
            }
        }
    }


    func play(channelSoundObj: PFObject)  {
        if let channelSoundFile = channelSoundObj["sound"] as? PFFile {
            if let soundURL = NSURL(string: channelSoundFile.url!) {
                let soundItem  = AVPlayerItem(URL: soundURL)
                audioPlayer = AVPlayer(playerItem: soundItem)
                audioPlayer.play()
            }
        }
    }
}

