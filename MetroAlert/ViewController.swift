//
//  ViewController.swift
//  MetroAlert
//
//  Created by Youngmin Cho on 12/27/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocation(notification:)), name: Notification.Name("LocationObserver"), object: nil)
    }

    @IBAction func getLocationPressed(_ sender: UIButton) {
        locationManager.getUpdate()
    }
    
    @objc func updateLocation(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let latitude = userInfo["latitude"] as? Double,
              let longitude = userInfo["longitude"] as? Double else {
            print("ERROR")
            return
        }
        
        self.locationLabel.text = "latitude: \(latitude)\n\nlongitude: \(longitude)"
    }
    
}

