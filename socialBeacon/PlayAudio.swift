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
        
        if (audioPlayer != nil && audioPlayer.playing) {
            audioPlayer.pause()
        }
        do {
            let sound = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer = sound
            audioPlayer.play()
        } catch {
            // Could not load the file
            print("Could not load")
            audioPlayer = nil
            throw AudioError.FileNotFound
        }
    }
    
    func preLoadSong(fileName: String, type: String?) throws -> AVAudioPlayer {
        let path: String = NSBundle.mainBundle().pathForResource(fileName, ofType: type)!
        let url: NSURL = NSURL(fileURLWithPath: path)
        
        do {
            let bufferedSong = try AVAudioPlayer(contentsOfURL: url)
            bufferedSong.prepareToPlay()
            return bufferedSong
        } catch {
            throw AudioError.FileNotFound
        }
    }
    
    func playPreLoadedSong(songPlayer: AVAudioPlayer) {
        if (audioPlayer != nil && audioPlayer.playing) {
            audioPlayer.pause()
        }
        audioPlayer = songPlayer
        audioPlayer.play()
    }
}