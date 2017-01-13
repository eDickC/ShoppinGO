//
//  ViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 09/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ESTBeaconManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    class Beacon {
        var name: String = ""
        var id: String = ""
    }
    
    var beacons = [Beacon]()
    let beaconManager = ESTBeaconManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        
        self.beaconManager.startMonitoring(for: CLBeaconRegion(
            proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID,
            major: 17845, minor: 35750, identifier: "blue"))

        self.beaconManager.startMonitoring(for: CLBeaconRegion(
            proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID,
            major: 51550, minor: 31229, identifier: "dark blue"))

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("enter area of beacon")
        
        if region.identifier == "blue" {
            let beacon = Beacon()
            beacon.name = region.identifier
            beacon.id = region.proximityUUID.uuidString
            beacons.append(beacon)
            
            createNotification(beacon)
        }
        
        if region.identifier == "dark blue" {
            let beacon = Beacon()
            beacon.name = region.identifier
            beacon.id = region.proximityUUID.uuidString
            beacons.append(beacon)
            
            createNotification(beacon)
        }
        
        tableView.reloadData()
    }
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        if region.identifier == "blue" {
            beacons.removeAll()
        }
        
        if region.identifier == "dark blue" {
            beacons.removeAll()
        }
        
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beaconCell") as! BeaconTableViewCell
        let beacon = beacons[indexPath.row]
        
        cell.beaconName.text = beacon.name
        cell.beaconID.text = beacon.id
        
        return cell
    }
    
    func createNotification(_ beacon: Beacon) {
        let notificationIdentifier = beacon.id
        let content = UNMutableNotificationContent()
        content.title = "ShoppinGO"
        content.body = beacon.name
        content.sound = UNNotificationSound.default()
        
        let triggerd = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest.init(identifier: notificationIdentifier, content: content, trigger: triggerd)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request)
    }
}


