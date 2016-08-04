//
//  TodayViewController.swift
//  WeatherAppExtenion
//
//  Created by Toleen Jaradat on 8/2/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var tempButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 0, height: 40)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func weatherButtonPressed(sender: AnyObject) {
        let url:NSURL = NSURL.fileURLWithPath("weather://recent")
        extensionContext?.openURL(url, completionHandler: nil)
    }
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        
        
        let userDefaults = NSUserDefaults(suiteName: "group.toleenjaradat.WeatherApp")
        
        //self.tempButton.backgroundColor = UIColor.whiteColor()
        let title = "Today's Local Weather Temperature is: " + ((userDefaults?.valueForKey("Temperature"))! as! String) 
        self.tempButton.setTitle( title , forState: .Normal)
        
        print(self.tempButton.titleLabel)
    
        completionHandler(NCUpdateResult.NewData)
    }
    
}
