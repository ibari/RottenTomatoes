//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Ian on 5/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var synopsisLabel: UILabel!
  
  var movie: NSDictionary!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageUrl = NSURL(string: movie.valueForKeyPath("posters.original") as! String)!
    
    titleLabel.text = movie["title"] as! String!
    synopsisLabel.text = movie["synopsis"] as! String!
    synopsisLabel.sizeToFit()
    imageView.setImageWithURL(imageUrl)
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
