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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = streamTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
