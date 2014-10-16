//
//  YelpClient.swift
//  yelp
//
//  Created by Niaz Jalal on 9/22/14.
//  Copyright (c) 2014 Niaz Jalal. All rights reserved.
//

import UIKit

let yelpConsumerKey = "XXXXXX"
let yelpConsumerSecret = "XXXXXX"
let yelpToken = "XXXXXX"
let yelpTokenSecret = "XXXXXX"

class YelpClient: BDBOAuth1RequestOperationManager {
    
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    class var sharedInstance : YelpClient {
    
    struct Static {
        static var token : dispatch_once_t = 0
        static var instance : YelpClient? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        }
        
        return Static.instance!
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var parameters = ["term": term, "location": "San Francisco"]
        return self.GET("search", parameters: parameters, success: success, failure: failure)
    }
}