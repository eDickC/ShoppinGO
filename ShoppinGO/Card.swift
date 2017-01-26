//
//  Card.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 21/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import Foundation
import RealmSwift

class Card: Object {
    dynamic var name = ""
    dynamic var code = ""
    dynamic var codeType = ""
    dynamic var holderName = ""
}
