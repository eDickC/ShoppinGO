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
        static let editCard = "editCard"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cards.removeAll()
        DispatchQueue.global().async {
            let realm = try! Realm()
            let cards = realm.objects(Card.self)
            
            for card in cards {
                var temporaryCard = Card()
                temporaryCard.id = card.id
                temporaryCard.code = card.code
                temporaryCard.holderName = card.holderName
                temporaryCard.name = card.name
                temporaryCard.codeType = card.codeType
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CardViewIdentifiers.editCard {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddCardViewController
            controller.card = cards[(sender as! IndexPath).row]
        }
    }
    
    // MARK: CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardViewIdentifiers.cardCell, for: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        
        cell.cofigureCell(card: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: CardViewIdentifiers.editCard, sender: indexPath)
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
