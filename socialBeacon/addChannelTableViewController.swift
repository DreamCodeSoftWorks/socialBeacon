//
//  ChannelViewController.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit

class AddChannelTableViewController: UITableViewController {
    
    var selected = 0
    var twitterTrendsArray : [String]?
    var selectedTwitterTrend : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channelCell") as UITableViewCell!
        //Change to implement twitter hashtag names
        //cell.textLabel?.text = channelArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Determines how many cells in a tableViewController
        //return channelArray.count
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = indexPath.row
        performSegueWithIdentifier("addChannelSegue", sender: nil)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addChannelSegue" {
            if let dest = segue.destinationViewController as? streamViewController {
                dest.streamTitle = twitterTrendsArray![selected]
            }
        }
    }
    
}
