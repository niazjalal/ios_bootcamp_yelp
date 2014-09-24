//
//  FilterViewController.swift
//  yelp
//
//  Created by Niaz Jalal on 9/22/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit
/*
protocol FilterViewControllerDelegate {
    
    func searchTermDidChange
}*/

class FilterViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {

    @IBOutlet weak var FilterTableView: UITableView!
    
    //var delegate: FilterViewControllerDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*FilterTableView.dataSource = self
        FilterTableView.delegate = self*/
        
        self.FilterTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    /* NAJ: To Fix
    func func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        var cell = FilterTableView.dequeueReusableCellWithIdentifier("PriceCell") as PriceCell!
    }*/
    
    @IBAction func onCancelButton(sender: AnyObject) {
    
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onSearchButton(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
