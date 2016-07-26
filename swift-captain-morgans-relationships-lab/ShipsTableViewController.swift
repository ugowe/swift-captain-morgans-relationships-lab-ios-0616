//
//  ShipsTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Ugowe on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipsTableViewController: UITableViewController {
    
    var ships: Set<Ship> = []
    let managedShipObjects: [Ship] = []
    let store: DataStore = DataStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        store.fetchData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ships.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shipCell", forIndexPath: indexPath)

        let shipArray = Array(ships)
        let eachShip = shipArray[indexPath.row]
        cell.textLabel?.text = eachShip.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let shipDestinationVC = segue.destinationViewController as! ShipDetailViewController
        let shipArray = Array(ships)
        let selectedShip = shipArray[tableView.indexPathForSelectedRow!.row]
        
        shipDestinationVC.specificShip = selectedShip
        
        
    }


}
