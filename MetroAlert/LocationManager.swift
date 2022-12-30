//
//  LocationManager.swift
//  MetroAlert
//
//  Created by Youngmin Cho on 12/27/22.
//

import Foundation
import CoreLocation

internal class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var locationTimer: Timer?
    var networkReachability: NetworkReachability!
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestAlwaysAuthorization()
        self.networkReachability = NetworkReachability()
    }
    
    @objc func getUpdate() {
        guard let locationManager = self.locationManager else {
            return
        }
        
        guard self.networkReachability.isNetworkAvailable() else {
            return
        }
        
        locationManager.startUpdatingLocation()
        
        if self.locationTimer == nil {
            self.initializeTimer()
        }
    }
    
    func initializeTimer() {
        self.locationTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(getUpdate), userInfo: nil, repeats: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("CALLED")
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            
            NotificationCenter.default.post(name: Notification.Name("LocationObserver"), object: nil, userInfo: ["latitude": latitude, "longitude": longitude])
        }
    }
}
