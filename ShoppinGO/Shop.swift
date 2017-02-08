//
//  Shop.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 08/02/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import Foundation

import RealmSwift

class Shop: Object {
    dynamic var name = ""
    dynamic var beaconUUID = 0
    dynamic var beaconMajor = 0
    dynamic var beaconMinor = 0
    let cards = List<Card>()
}
