//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by doug harper on 9/13/15.
//  Copyright © 2015 Doug Harper. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appDataArray = [AppData]()

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
                
                
                print("before")
                let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {
                    (data: NSData?, response: NSURLResponse?, error: NSError?) in
                    
                    if error != nil {
                        print("Error: \(error?.localizedDescription)")
                    } else {
                        //print("data: \(data)")
                        
                        var jsonError = NSError?.self
                        
                        do {
                            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                             print("jsonData: \(jsonData)")
                            print("response")
                            
                            if let resultsArray = jsonData["results"] as? NSArray {
                                
                                var appDataArray = [AppData]()
                                
                                // iterate over the array
                                for item in resultsArray {
                                    
                                    if let artworkURLString =  item["artworkUrl60"] as? NSString {
                                        print("artwork: \(artworkURLString)")
                                        
                                        if let artistName = item["artistName"] as? NSString {
                                            print("artist: \(artistName)")
                                            
                                            if let appName = item["trackCensoredName"] as? String? {
                                                print("app: \(appName)")
                                                
                                                
                                                let appData = AppData(authorName: artistName as String, appName: (appName)!, imageURLString: artworkURLString as String)
                                                
                                                appDataArray.append(appData)
                                                
                                            
                                                }
                                            }
                                        }
                                }
                               
                                // add Grand Central Dispatch
                                dispatch_async(dispatch_get_main_queue(), {
                                    
                                    self.appDataArray = appDataArray
                                    print("app data: \(self.appDataArray)")
                                    
                                })
                                
                            }
                            
                            
                            
                        } catch {
                            print("do catch error")
                        }
                        
                    }
                    
                    
                    
                })
                
                dataTask.resume()
                print("end")
                
            }
            
            
        }  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Table View Data Source Methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = NSDate().description
        
        return cell
    }

    
    
    
    

}

