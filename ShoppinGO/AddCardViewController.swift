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

    var card: Card?
    var pickerDataSource = ["Tchibo", "InterSport", "AlpinePro"]
    var selectedInPicker = ""
    
    //IBOUTLETS
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardholderName: UITextField!
    @IBOutlet weak var cardCodeLabel: UITextField!
    @IBOutlet weak var cardCodeImage: UIImageView!
    var cardCodeType = ""
    @IBOutlet weak var cardTypePicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardTypePicker.delegate = self
        cardTypePicker.dataSource = self
        
        if let card = card {
            cardNameTextField.text = card.name
            cardholderName.text = card.holderName
            cardCodeLabel.text = card.code
            cardCodeImage.image = card.codeImage()
        }
        
        cardCodeImage.layer.borderWidth = 1
        cardCodeImage.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        cardCodeImage.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveCard(_ sender: UIBarButtonItem) {
        let realm = try! Realm()

        if let card = card {
            try! realm.write {
                card.name = self.cardNameTextField.text!
                card.holderName = self.cardholderName.text!
                card.code = self.cardCodeLabel.text!
                card.codeType = self.cardCodeType
                card.image = selectedInPicker
                realm.add(card, update: true)
            }
        } else {
            try! realm.write {
                realm.create(Card.self, value: [self.cardNameTextField.text!, self.cardCodeLabel.text!, self.cardCodeType, self.cardholderName.text!, selectedInPicker], update: false)
            }
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
                self.cardCodeType = capturedCodeType
                switch capturedCodeType {
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

extension AddCardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedInPicker = pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    

}

