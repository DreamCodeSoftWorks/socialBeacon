//
//  ChannelViewController.swift
//  socialBeacon
//
//  Created by Omar Skalli on 2/6/16.
//  Copyright © 2016 cmu. All rights reserved.
//

import UIKit

class ChannelTableViewController: UITableViewController {
    
    var channelArray: [String] = []
    var selected = 0
    var selectedTwitterTrend : String?
    
    var channelRefreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelArray = ["Super Bowl 50", "Democratic Debate", "Party Channel", "Local Channel"]
        tableView.reloadData()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: "refreshChannels:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
    }
    
    func refreshChannels(refreshControl: UIRefreshControl) {
        //Pull new channel list from parse
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell!
        cell.textLabel?.text = channelArray[indexPath.row]
        return cell
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return channelArray.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = indexPath.row
        performSegueWithIdentifier("channelSegue", sender: nil)
    }
    

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "channelSegue" {
            if let dest = segue.destinationViewController as? streamViewController {
                dest.streamTitle = channelArray[selected]
            }
        }
    }
    
    @IBAction func unwindFromAddChannel(segue: UIStoryboardSegue) {
        print("unwinding...")
    }

}
