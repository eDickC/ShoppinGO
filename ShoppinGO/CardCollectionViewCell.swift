//
//  CardCollectionViewCell.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 21/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardholderName: UILabel!
    @IBOutlet weak var cardCode: UILabel!
    
    func cofigureCell(card: Card) {
        cardholderName.text = card.cardHolderName
        cardCode.text = card.cardCode
        
        self.layer.cornerRadius = 10
    }
}
