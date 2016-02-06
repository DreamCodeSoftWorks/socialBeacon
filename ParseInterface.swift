//
// ParseInterface.swift
// socialBeacon
//
// Created by Arjun Hans on 2/5/16.
// Copyright © 2016 cmu. All rights reserved.
//
import UIKit
import Parse
import AVFoundation

class ParseInterface {
    var audioPlayer = AVQueuePlayer()

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

    static func uploadParseSound(channelName : String, recordingName : String) {
        print("Uploading sound \(recordingName) for channel \(channelName)")
        let soundPath = RecordViewController.getFileURL()
        print(soundPath)
        let soundParseFile = PFFile(name: recordingName, data: NSData(contentsOfURL:soundPath)!)
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
    
    func downloadChannelSounds(channelName : String, streamView : streamViewController) {
        let query = PFQuery(className: "channelSound")
        var soundItems = [AVPlayerItem]()
        query.whereKey("channelName", equalTo: channelName)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Found \(objects!.count) snippets for \(channelName)")
                for object in objects! {
                    if let channelSoundFile = object["sound"] as? PFFile {
                        if let soundURL = NSURL(string: channelSoundFile.url!) {
                            print(soundURL)
                            streamView.channelSounds.append(object)
                            let soundItem = AVPlayerItem(URL: soundURL)
                            soundItems.append(soundItem)
                        }
                    }
                }
            } else {
                NSLog("Error, couldn't load sounds")
            }
            print("Playing sounds")
            self.audioPlayer = AVQueuePlayer(items: soundItems)
            self.audioPlayer.play()
        }
 
    }
    
    func playChannelSounds(channelSoundObjs: [PFObject]) {
        print("Playing sounds \(channelSoundObjs.count)")
        
        for channelSoundObject in channelSoundObjs {
            if let channelSoundFile = channelSoundObject["sound"] as? PFFile {
                if let soundURL = NSURL(string: channelSoundFile.url!) {
                    print("Sound at \(soundURL)")
                    let soundItem = AVPlayerItem(URL: soundURL)
                    //audioPlayer = AVPlayer(playerItem: soundItem)
                    //audioPlayer.play()
                }
            }
        }
    }
}