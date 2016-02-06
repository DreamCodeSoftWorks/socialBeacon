//
//  streamViewController.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import Parse

public var AudioPlayer = AVPlayer()
public var SelectedSongNumber = Int()

class streamViewController: UIViewController {
    
    var streamTitle: String?
    var channelSounds: [PFObject]?

    @IBAction func playButton(sender: AnyObject) {
        //ParseInterface.playChannelSounds(channelSounds!)

    }
    @IBAction func recordButton(sender: AnyObject) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = streamTitle
        //ParseInterface.downloadChannelSounds(streamTitle!, channelSounds: channelSounds!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
