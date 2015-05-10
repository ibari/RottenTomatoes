//
//  AlertViewController.swift
//  RottenTomatoes
//
//  Created by Ian on 5/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var messageLabel: UILabel!
  
  var alertTitle: String?
  var alertMessage: String?
  
  /*required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
    self.alertTitle = "Error"
    self.alertMessage = "Doh!"
    super.init(nibName: nil, bundle: nil)
  }
  
  convenience init(title: String, message: String) {
    self.init(nibName: nil, bundle: nil)
    
    self.alertTitle = title
    self.alertMessage = message
  }*/

  override func viewDidLoad() {
    super.viewDidLoad()
    
    titleLabel.text = "\u{f071} " + alertTitle!
    messageLabel.text = alertMessage!
    messageLabel.sizeToFit()
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
