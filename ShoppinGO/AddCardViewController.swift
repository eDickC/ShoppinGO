//
//  AddCardViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 16/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import RealmSwift
import ZXingObjC
import AVFoundation

class AddCardViewController: UIViewController {

    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardholderName: UITextField!
    @IBOutlet weak var cardCodeLabel: UILabel!
    @IBOutlet weak var cardCodeImage: UIImageView!
    var cardCodeType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCard(_ sender: UIBarButtonItem) {
        let card = Card()
        card.cardName = cardNameTextField.text!
        card.cardHolderName = cardholderName.text!
        card.cardCode = cardCodeLabel.text!
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(card)
        }
        
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToAddCardScreen(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? ScannerController {
            cardCodeLabel.text = sourceViewController.capturedCode
            var format: ZXBarcodeFormat?
            if let capturedCodeType = sourceViewController.capturedCodeType {
                cardCodeType = capturedCodeType
                
                switch cardCodeType {
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
            }
            
            do {
                let writer = ZXMultiFormatWriter()
                let hints = ZXEncodeHints()
                if let format = format {
                    let result = try writer.encode(cardCodeLabel.text, format: format, width: 1000, height: 1000)
                    let image = ZXImage(matrix: result)
                    cardCodeImage.image = UIImage(cgImage: image!.cgimage)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Your code wasn't recoginized", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
                }
                
            } catch {
                print(error)
            }
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
