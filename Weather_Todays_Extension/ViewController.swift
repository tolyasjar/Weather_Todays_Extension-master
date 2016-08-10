//
//  ViewController.swift
//  Weather_Todays_Extension
//
//  Created by Toleen Jaradat on 8/2/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var temperature = String()
    var locationManager :CLLocationManager!

    override func viewDidLoad() {
    super.viewDidLoad()
        
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
        
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.distanceFilter = kCLDistanceFilterNone
        
    self.locationManager.requestWhenInUseAuthorization()
        
    self.locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userlocation: CLLocation = locations[0]
        print("HI")
        let latitude  =  String (userlocation.coordinate.latitude)
        let longitude = String (userlocation.coordinate.longitude)
        let weatherAPI = "https://api.forecast.io/forecast/ee590865b8cf07d544c96463ae5d47c5/\(latitude),\(longitude)"
        print(weatherAPI)
        guard let url = NSURL(string: weatherAPI) else {
            
            fatalError("Invalid URL")
        }
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(url) { (data :NSData?, response :NSURLResponse?, error :NSError?) in
            
            let jsonData = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            
            let currentData = jsonData.valueForKey("currently")
            print (currentData)
            
            let temperature = currentData?.valueForKey("temperature") as! Double
            let windSpeed = currentData?.valueForKey("windSpeed") as! Double
            let visibility = currentData?.valueForKey("visibility") as! Double
            let humidity = currentData?.valueForKey("humidity") as! Double
            let summary = currentData?.valueForKey("summary") as! String
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.temperature = String(format:"%.2f",temperature)
                self.temperatureLabel.text = self.temperature
                
                self.windSpeedLabel.text = String(format:"%.2f",windSpeed)
                self.visibilityLabel.text = String(format:"%.2f",visibility)
                self.humidityLabel.text = String(format:"%.2f",humidity)
                self.summaryLabel.text = summary
                
                
                //print(self.temperature)
                
                let userDefaults = NSUserDefaults(suiteName: "group.toleenjaradat.WeatherApp")
                
                userDefaults?.setObject(self.temperature, forKey: "Temperature")
                userDefaults?.synchronize()
                
            })
            
            }.resume()

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

