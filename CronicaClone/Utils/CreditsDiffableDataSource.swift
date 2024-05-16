//
//  CreditsDiffableDataSource.swift
//  CronicaClone
//
//  Created by Hakan Or on 14.05.2024.
//

import UIKit

class CreditsDiffableDataSource: UICollectionViewDiffableDataSource<Section, CreditsResponse.Person> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
            cell.configure(with: item)
            return cell
        }
    }
}
