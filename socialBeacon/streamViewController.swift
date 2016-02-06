//
//  streamViewController.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit

public var AudioPlayer = AVPlayer()
public var SelectedSongNumber = Int()

class streamViewController: UIViewController {
    
    var streamTitle: String?
    var channelSounds: [PFObject] = []

    @IBAction func playButton(sender: AnyObject) {
        ParseInterface.playChannelSounds(channelSounds)

    }
    @IBAction func recordButton(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = streamTitle
        ParseInterface.downloadChannelSounds(streamTitle!, streamView: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recordSegue" {
            if let dest = segue.destinationViewController as? RecordViewController {
                dest.streamTitle = streamTitle
            }
        }
    }
    
}
