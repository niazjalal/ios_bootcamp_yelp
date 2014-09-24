//
//  RestaurantViewController.swift
//  yelp
//
//  Created by Niaz Jalal on 9/22/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

/*
NAJ: Fix List
    - Categories data from YELP API
    - Search Page Search Bar in NavigationController
    - Distance using Location
    -
*/

import UIKit
import CoreLocation

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate/*, FilterViewControllerDelegate*/ {
    
    @IBOutlet weak var tableView: UITableView!

    //var restaurants: [RestaurantObject]! = []
    var restaurants: [NSDictionary]! = []
    
    var client: YelpClient!
    
    let yelpConsumerKey = "SMlMhJm5UsH9l3XdPBektg"
    let yelpConsumerSecret = "NsBLz8t-KtTKHavxqz0dg1-KKG4"
    let yelpToken = "VV7yKcNj5dwonncNX7JSyEgIQDu6cOfj"
    let yelpTokenSecret = "kcuTdp5ccBcUDi4OzGEb5kf8NTI"
    var isExpanded: [Int:Bool] = [Int:Bool]()
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            println(response)
            
            self.restaurants = (response as NSDictionary)["businesses"] as [NSDictionary]
            
            self.tableView.reloadData()
            }) { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                
                println(error)
        }
        
        /*RestaurantObject.searchWithQuery("Thai") { (restaurants: [RestaurantObject], error: NSError())
            
            
        }*/
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        /*if let expanded = isExpanded[section] {
            return expanded ? restaurants.count : 1
        } else {
            return 1
        }*/
        return restaurants.count
    }
    
    /*func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell") as RestaurantCell

        var restaurant = self.restaurants[indexPath.row]

        var count = restaurant["review_count"] as Int
        var reviews = "\(count) Reviews"
        var addressList = restaurant["location"]!["display_address"] as? NSArray
        var address = addressList?.componentsJoinedByString(", ") as String!
        /*var categoryList = restaurant["categories"]! as? NSArray
        //var categories = categoryList?.componentsJoinedByString(", ") as String!
        
        var categories: NSMutableArray
        
        for category in restaurant["categories"] as NSArray! {
            for item in category as String {
            
                categories.addObjectsFromArray(item)
            }
            
            //println("\(category)")
            
        }*/
        
        //println("categoryList:\n  \(categoryList)")
        //println("categories:\n   \(categories)")
        
        //println("\(address)")
        //println("\(reviews)")
        
        /*if let location = restaurant["location"] as? NSDictionary {
            let address = location["city"] as? NSDictionary
            println("\(location)")
            println("\(address)")
        }*/
        //var location = restaurant["location"] as? NSDictionary
        //var address = location[location["address"]] as? NSArray
        //println("\(location)")
        //println("\(address)")
        /*
        let address = restaurant["location"]!["cross_streets"]! as? NSString
        println("\(address)")
        */
        
        var trip = "0.2 miles"
        
        var loc = restaurant["region"]?["center"]? as? NSArray
        //var lat = loc["lattitude"] as String!
        
        println("\(loc)")
        
        if locationManager.location != nil {
            //var lat = restaurant["location"]!["coordinate"]!["lattitude"] as NSString!
            //var long = restaurant["location"]!["coordinate"]!["longitude"]! as NSString!
            //var newLocation = CLLocation(latitude: restaurant["location"]!["coordinate"]!["lattitude"]! as CLLocationDegrees!, longitude: restaurant["location"]!["coordinate"]!["longitude"]! as CLLocationDegrees!)
            
        } else {
            trip = "0.8 miles"
        }
        //println("\(locationManager.location)")
        
        //println("\(locationManager.location.coordinate.latitude)")
        //println("\(locationManager.location.coordinate.longitude)")
        
        /* NAJ: TOFIX - using hard-coded value for distance */
        cell.restaurantImageView.setImageWithURL(NSURL(string: restaurant["image_url"] as NSString))
        cell.restaurantLabel.text = restaurant["name"] as? NSString
        cell.distanceLabel.text = trip
        cell.ratingImageView.setImageWithURL(NSURL(string: restaurant["rating_img_url"] as NSString))
        cell.reviewsLabel.text = reviews
        cell.addressLabel.text = address
        /* NAJ: TOFIX - using hardcoded value for category */
        cell.categoriesLabel.text = "Thai, thai"
        //cell.categoriesLabel.text = categories


        /* colors */
        cell.restaurantLabel.textColor = UIColor.blackColor()
        cell.distanceLabel.textColor = UIColor.blackColor()
        cell.reviewsLabel.textColor = UIColor.blackColor()
        cell.addressLabel.textColor = UIColor.blackColor()
        cell.categoriesLabel.textColor = UIColor.blackColor()
        
        /*
        var x = restaurant["location"] as? NSDictionary
        //println("\(x)")
        var y = restaurant["location"]!["cross_streets"] as? NSString
        //println("\(y)")
        var z = restaurant["location"]!["display_address"] as? NSArray
        //println("\(z)")
        
        var s = z?.componentsJoinedByString(", ") as String!

        println("\(s)")*/
        
        return cell
    }
    

    /*func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        
        headerView.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        var headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 320, height: 50))
        
        headerLabel.text = "Section \(section)"
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let expanded = isExpanded[indexPath.section] {
            isExpanded[indexPath.section] = !expanded
        } else {
            isExpanded[indexPath.section] = true
        }
        
        //tableView.reloadData()
    }*/
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var filtersNavigationController = segue.destinationViewController as UINavigationController
        
        var filterViewController = filtersNavigationController.viewControllers[0] as FilterViewController.delegate = self
    }
    
    func searchTermDidChange() {
    
        // TODO:
    }*/
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        //println("locations = \(locations)")
        
        //println("\(locationManager.location.coordinate.latitude)")
        //println("\(locationManager.location.coordinate.longitude)")
        
        //currentLocation.coordinate.latitude = 0
        //currentLocation.coordinate.longitude = 0
        
        currentLocation = CLLocation(latitude: locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude)
        
        var xLocation: CLLocation = CLLocation(latitude: locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude)
        
        var newLocation: CLLocation = CLLocation(latitude: 1, longitude: 2)
        
        var distance = currentLocation.distanceFromLocation(newLocation)
        
        var xdistance = xLocation.distanceFromLocation(newLocation)
        
        //println("\(distance)")
    }
}

