//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Ian on 5/5/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var movies: [NSDictionary]?
  
  override func viewDidLoad() {    
    super.viewDidLoad()
    
    let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")!
    let request = NSURLRequest(URL: url)
    
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
      let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
      
      if let json = json {
        self.movies = json["movies"] as? [NSDictionary]
        self.tableView.reloadData()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
      }
      
      self.tableView.dataSource = self
      self.tableView.delegate = self
    }
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

// MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let movies = movies {
      return movies.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
    let movie = movies![indexPath.row]
    let url = NSURL(string: movie.valueForKeyPath("posters.original") as! String)!
  
    cell.titleLabel?.text = movie["title"] as? String
    cell.synopsisLabel?.text = movie["synopsis"] as? String
    cell.posterView.setImageWithURL(url)
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {}
