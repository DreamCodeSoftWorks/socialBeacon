//
//  PlayAudio.swift
//  socialBeacon
//
//  Created by Karim Elmaaroufi on 2/5/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import Foundation
import AVFoundation

class PlayAudio {
    var audioPlayer: AVAudioPlayer!
    
    /* Note: if the fileName already contains the extension, the type arguement may
    * be left null otherwise the type should be a string of the file extension
    */
    func play(fileName: String, type: String?) throws {
        let path: String = NSBundle.mainBundle().pathForResource(fileName, ofType: type)!
        let url: NSURL = NSURL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer = sound
            audioPlayer.play()
        } catch {
            // Could not load the file
            print("Could not load")
            throw error
        }
    }
}