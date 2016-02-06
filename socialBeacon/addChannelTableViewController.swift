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
    var twitterTrendsArray = ["#NBAFinals", "#BlackLivesMatter", "#TPPNotCool", "#ImWithStupid"]
    
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
        cell.textLabel?.text = twitterTrendsArray[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Determines how many cells in a tableViewController
        return twitterTrendsArray.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = indexPath.row
        performSegueWithIdentifier("addChannelUnwind", sender: nil)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addChannelUnwind" {
            if let dest = segue.destinationViewController as? ChannelTableViewController {
                //dest.selectedTwitterTrend = twitterTrendsArray![selected]
                dest.channelArray.append(twitterTrendsArray[selected])
            }
        }
        
    }
    
}
