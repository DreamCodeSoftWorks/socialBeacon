//
//  AudioErrorTypes.swift
//  socialBeacon
//
//  Created by Karim Elmaaroufi on 2/5/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import Foundation

enum AudioError: ErrorType {
    case Playback
    case Recording
    case FileNotFound
}