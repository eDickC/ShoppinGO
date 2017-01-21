//
//  CardViewController.swift
//  ShoppinGO
//
//  Created by Eduard Cihuňka on 21/01/2017.
//  Copyright © 2017 Eduard Cihuňka. All rights reserved.
//

import UIKit
import RealmSwift

class CardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    struct CardViewIdentifiers {
        static let cardCell = "cardCollectionViewCell"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cards.removeAll()
        DispatchQueue.global().async {
            let realm = try! Realm()
            let cards = realm.objects(Card.self)
            var temporaryCard = Card()
            for card in cards {
                temporaryCard.cardCode = card.cardCode
                temporaryCard.cardHolderName = card.cardHolderName
                temporaryCard.cardName = card.cardName
                self.cards.append(temporaryCard)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewIdentifiers.cardCell, for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        
        cell.cofigureCell(card: card)
        
        return cell
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
