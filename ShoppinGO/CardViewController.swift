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
        static let emptyView = "EmptyCardsView"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let realm = try! Realm()
    var cards = [Card]()
    var emptyCardsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyCardsView = Bundle.main.loadNibNamed(CardViewIdentifiers.emptyView, owner: self, options: [:])?[0]as! UIView
        emptyCardsView.frame = view.bounds
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cards.removeAll()
        DispatchQueue.global().async {
            let realm = try! Realm()
            let cards = realm.objects(Card.self)
            
            for card in cards {
                var temporaryCard = Card()
                temporaryCard.code = card.code
                temporaryCard.holderName = card.holderName
                temporaryCard.name = card.name
                temporaryCard.codeType = card.codeType
                temporaryCard.image = card.image
                self.cards.append(temporaryCard)
            }
            
            DispatchQueue.main.async {
                if self.cards.isEmpty {
                    self.view.addSubview(self.emptyCardsView)
                } else {
                    self.emptyCardsView.removeFromSuperview()
                    self.collectionView.reloadData()

                }
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
            let controller = navigationController.topViewController as! CardDetailController
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        return CGSize(width: width, height: 159)
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
