//
//  MovieDiffableDataSource.swift
//  CronicaClone
//
//  Created by Hakan Or on 13.05.2024.
//

import UIKit

class MoviesDiffableDataSource: UICollectionViewDiffableDataSource<Section, MovieResponse.Movie> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            cell.configure(with: item)
            return cell
        }
    }
}
