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
    static func downloadChannelSounds(channelName : String, streamView : streamViewController) {
        let query = PFQuery(className: "channelSound")
        query.whereKey("channelName", equalTo: channelName)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("Found \(objects!.count) snippets")
                for object in objects! {
                    streamView.channelSounds.append(object)
                }
            } else {
                NSLog("Error, couldn't load sounds")
            }
        }
    }
    
    static func playChannelSounds(channelSoundObjs: [PFObject]) {
        print("Playing sounds \(channelSoundObjs.count)")
        let url = NSURL(string: "https://files.parsetfss.com/95d6bbb4-ff13-4668-ae8e-27300694cf81/tfss-d3ba6911-ca8b-493d-a321-6f424dbb99b7-1-01%20Waiting%20On%20The%20World%20To%20Change.mp3")
        let playerItem = AVPlayerItem(URL: url!)
        let player = AVPlayer(playerItem: playerItem)
        player.play()
        
        /*for channelSoundObject in channelSoundObjs {
            if let channelSoundFile = channelSoundObject["sound"] as? PFFile {
                if let soundURL = NSURL(string: channelSoundFile.url!) {
                    print("Sound at \(soundURL)")
                    let soundItem = AVPlayerItem(URL: soundURL)
                    let audioPlayer = AVPlayer(playerItem: soundItem)
                    audioPlayer.play()
                }
            }
        }*/
    }
}