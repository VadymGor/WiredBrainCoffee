//
//  GiftViewController.swift
//  WiredBrainCoffee
//
//  Created by Vadym Horovyi on 16/04/2020.
//  Copyright © 2020 Mark Moeykens. All rights reserved.
//

import UIKit

class GiftViewController: UIViewController {
    
    @IBOutlet weak var seasonalHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var thankyouHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var seasonalCollectionView: UICollectionView!
    
    @IBOutlet weak var thankyouCollectionView: UICollectionView!
    
    var seasonalGiftCards = [GiftCardModel]()
    var thankyouDataSource: SmallGiftCardCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonalCollectionView.dataSource = self
        seasonalCollectionView.delegate = self
        
        GiftCardFunctions.getSeasonalGiftCards { [weak self] (cards) in
            guard let self = self else { return }
            self.seasonalGiftCards = cards
            self.seasonalCollectionView.reloadData()
        }
        
        GiftCardFunctions.getThankYouGiftCards { [weak self] (cards) in
            guard let self = self else { return }
            self.thankyouDataSource = SmallGiftCardCollectionViewDataSource(giftCards: cards)
            self.thankyouCollectionView.dataSource = self.thankyouDataSource
            self.thankyouCollectionView.delegate = self.thankyouDataSource
            self.thankyouCollectionView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setHeightOfCollectionView()
    }
    
    func setHeightOfCollectionView() {
        let width = seasonalCollectionView.bounds.width - 30
        let height = width / 1.5
        seasonalHeightConstraint.constant = height
        
        thankyouHeightConstraint.constant = height / 2
    }
}

extension GiftViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonalGiftCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiftCardCell", for: indexPath) as! GiftCardCollectionViewCell
        cell.setup(giftCardModel: seasonalGiftCards[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 50
        let height = width / 1.5
        return CGSize(width: width, height: height)
    }
}
