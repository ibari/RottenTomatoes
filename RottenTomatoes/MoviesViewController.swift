//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Ian on 5/5/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

private let resourceUrl = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")!

class MoviesViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var movies: [NSDictionary]?
  var refreshControl: UIRefreshControl!
  
  override func viewDidLoad() {    
    super.viewDidLoad()
    
    getMovies()
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)
  }
  
  func getMovies() {
    let request = NSURLRequest(URL: resourceUrl)
    
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, requestError: NSError!) -> Void in
      
      if let requestError = requestError {
        let alertViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Alert.storyboard") as! AlertViewController
        alertViewController.alertTitle = "Network Error"
        alertViewController.alertMessage = requestError.localizedDescription
        self.presentViewController(alertViewController, animated: true, completion: nil)
        
      } else {
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
        
        if let json = json {
          self.movies = json["movies"] as? [NSDictionary]
          self.tableView.reloadData()
          MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
      }
    })
  }
  
  func delay(delay:Double, closure:()->()) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(delay * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
  }
  
  func onRefresh() {
    delay(2, closure: {
      self.refreshControl.endRefreshing()
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPathForCell(cell)!
    
    let movieDetailsViewController = segue.destinationViewController as! MovieDetailsViewController
    movieDetailsViewController.movie = movies![indexPath.row]
  }
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
    var cell = tableView.dequeueReusableCellWithIdentifier("com.codepath.MovieCell", forIndexPath: indexPath) as! MovieCell
    let movie = movies![indexPath.row]
    let imageUrl = NSURL(string: movie.valueForKeyPath("posters.original") as! String)!
  
    cell.titleLabel?.text = movie["title"] as? String
    cell.synopsisLabel?.text = movie["synopsis"] as? String
    cell.posterView.setImageWithURL(imageUrl)
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
}

// MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {}
