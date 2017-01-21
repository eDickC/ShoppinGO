//
//  AddCardViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 16/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import RealmSwift

class AddCardViewController: UIViewController {

    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardholderName: UITextField!
    @IBOutlet weak var cardCodeLabel: UILabel!
    @IBOutlet weak var cardCodeImage: UIImageView!
    
    
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
            
            let data = cardCodeLabel.text?.data(using: String.Encoding.ascii)
            let filter = CIFilter(name: "CICode128BarcodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            cardCodeImage.image = UIImage(ciImage: (filter?.outputImage)!)

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
