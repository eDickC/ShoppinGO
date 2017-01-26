//
//  CardCollectionViewCell.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 21/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import ZXingObjC

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardholderName: UILabel!
    @IBOutlet weak var cardCode: UILabel!
    @IBOutlet weak var cardCodeImage: UIImageView!
    
    func cofigureCell(card: Card) {
        cardholderName.text = card.holderName
        cardCode.text = card.code
        
        self.layer.cornerRadius = 10

        if let image = card.codeImage() {
            cardCodeImage.image = card.codeImage()
        } else {
            cardCodeImage.image = nil
        }
    }
}
