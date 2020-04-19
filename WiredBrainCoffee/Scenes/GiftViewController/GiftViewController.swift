//
//  GiftViewController.swift
//  WiredBrainCoffee
//
//  Created by Vadym Horovyi on 16/04/2020.
//  Copyright © 2020 Mark Moeykens. All rights reserved.
//

import UIKit

class GiftViewController: UIViewController {
    
    @IBOutlet weak var seasonalCollectionView: UICollectionView!
    
    var seasonalGiftCards = [GiftCardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seasonalCollectionView.dataSource = self
        seasonalCollectionView.delegate = self
        
        GiftCardFunctions.getSeasonalGiftCards { [weak self] (cards) in
            guard let self = self else { return }
            self.seasonalGiftCards = cards
            self.seasonalCollectionView.reloadData()
        }
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
        
        let columns: CGFloat = 2
        
        // Get the width of the collection view
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        // Get the value for the space between the cells
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        // Subtract the cells spacing from the collection view's width
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        // Divide the adjusted width by columns
        // floor: Rounds a number down to the nearest hole number
        let width: CGFloat = floor (adjustedWidth / columns)
        let height: CGFloat = width / 1.5
        return CGSize(width: width, height: height)
    }
    
    // Sections Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath)
        return view
    }
}
