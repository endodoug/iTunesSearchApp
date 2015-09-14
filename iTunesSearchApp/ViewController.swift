//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by doug harper on 9/13/15.
//  Copyright © 2015 Doug Harper. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up string to represent search term
        let searchTerm = "Doug Harper"
        if let escapedSearchTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            
            print(escapedSearchTerm)
            
            // create search string
            let searchString = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&entity=software"
            print(searchString)
            
            // create URL String
            
            if let url = NSURL(string: searchString) {
                
                let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
                    (data: NSData?, response: NSURLResponse?, error: NSError?) in
                    
                    if error != nil {
                        print("Error: \(error?.localizedDescription)")
                    } else {
                        print("data: \(data)")
                        
                        var jsonError = NSError?.self
                        
                        do {
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                             print("jsonData: \(jsonData)")
                        } catch {
                            print("do catch error")
                        }
                        
                    }
                    
                    
                    
                })
                
                dataTask.resume()
                
            }
            
            
        }  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

