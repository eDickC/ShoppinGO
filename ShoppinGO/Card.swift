//
//  Card.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 21/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import Foundation
import RealmSwift
import ZXingObjC

class Card: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var code = ""
    dynamic var codeType = ""
    dynamic var holderName = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func codeImage() -> UIImage? {
        
        let writer = ZXMultiFormatWriter()
        let format: ZXBarcodeFormat?
        
        switch codeType {
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
                let result = try writer.encode(code, format: format, width: 1000, height: 1000)
                let image = ZXImage(matrix: result)
                return UIImage(cgImage: image!.cgimage)
            } catch {
                print(error)
            }
        }

        return nil
    }
}
