//
//  ShipDetailViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Ugowe on 7/25/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    
    var specificShip: Ship!
    let store: DataStore = DataStore()

    @IBOutlet weak var shipNameLabel: UILabel!
    @IBOutlet weak var pirateNameLabel: UILabel!
    @IBOutlet weak var propulsionTypeLabel: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        store.fetchData()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shipNameLabel.text = specificShip.name
        pirateNameLabel.text = specificShip.pirate?.name
        propulsionTypeLabel.text = specificShip.engine?.propulsion
        
        
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
