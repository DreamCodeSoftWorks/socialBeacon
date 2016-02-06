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

    @IBOutlet var RateLabel: UILabel!
    @IBOutlet var RateSlider: UISlider!
    var parseInt : ParseInterface
    var currentValue: Float?
    var streamTitle: String?
    var channelSounds: [PFObject] = []

    @IBAction func playButton(sender: AnyObject) {
        parseInt.playChannelSounds(channelSounds)
        RateSlider.value = 1.0
        RateLabel.text = "1.0x Speed"
    }
    @IBAction func recordButton(sender: AnyObject) {
        parseInt.stopChannelSounds()
    }
    @IBAction func SliderChanged(sender: UISlider) {
        currentValue = sender.value
        RateLabel.text = "\(currentValue!)x Speed"
        parseInt.audioPlayer.rate = currentValue!
    }

    required init(coder decoder: NSCoder) {
        parseInt = ParseInterface()
        super.init(coder: decoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = streamTitle
        RateSlider.value = 1.0
        RateLabel.text = "1.0x Speed"
        currentValue = 1.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        parseInt.downloadChannelSounds(streamTitle!, streamView: self)
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
