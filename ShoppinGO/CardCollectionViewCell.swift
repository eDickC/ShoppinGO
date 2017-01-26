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

        let writer = ZXMultiFormatWriter()
        let format: ZXBarcodeFormat?
        
        print(card.codeType)
        switch card.codeType {
        case AVMetadataObjectTypeUPCECode:
            format = kBarcodeFormatEan13
        case AVMetadataObjectTypeEAN8Code:
            format = kBarcodeFormatEan8
        case AVMetadataObjectTypeEAN13Code:
            format = kBarcodeFormatEan13
        case AVMetadataObjectTypeCode39Code:
            format = kBarcodeFormatCode39
        case AVMetadataObjectTypeUPCECode:
            format = kBarcodeFormatUPCE
        case AVMetadataObjectTypeCode128Code:
            format = kBarcodeFormatCode128
        case AVMetadataObjectTypeITF14Code:
            format = kBarcodeFormatITF
        case AVMetadataObjectTypeQRCode:
            format = kBarcodeFormatQRCode
        case AVMetadataObjectTypeDataMatrixCode:
            format = kBarcodeFormatDataMatrix
        case AVMetadataObjectTypeAztecCode:
            format = kBarcodeFormatAztec
        case AVMetadataObjectTypePDF417Code:
            format = kBarcodeFormatPDF417
        default:
            format = nil
        }
        
        if let format = format {
            do {
                let result = try writer.encode(card.code, format: format, width: 1000, height: 1000)
                let image = ZXImage(matrix: result)
                cardCodeImage.image = UIImage(cgImage: image!.cgimage)
            } catch {
                print(error)
            }
            
        }
        
    }
}
