//
//  File.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 08/02/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import Foundation
import RealmSwift

class ShoppingCentre: Object {
    dynamic var name = ""
    let shops = List<Shop>()
}
