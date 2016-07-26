//
//  PiratesTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Ugowe on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class PiratesTableViewController: UITableViewController {
    
    var managedPirateObjects: [Pirate] = []
    let store: DataStore = DataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        store.fetchData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.pirates.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pirateCell", forIndexPath: indexPath)

        let eachPirate = store.pirates[indexPath.row]
        cell.textLabel?.text = eachPirate.name

        return cell
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let indexPath = tableView.indexPathForSelectedRow
        
        let destinationVC = segue.destinationViewController as! ShipsTableViewController
        
        let selectedPirate = store.pirates[indexPath!.row]
        
        if let shipSet = selectedPirate.ships{
            destinationVC.ships = shipSet
        }
        
        
    }


}
