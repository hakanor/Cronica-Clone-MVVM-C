//
//  PersonCell.swift
//  CronicaClone
//
//  Created by Hakan Or on 14.05.2024.
//

import UIKit

class PersonCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with person: CreditsResponse.Person) {
        // It can be further improved, but since the focus of the application was
        // on the Coordinator pattern, the image was obtained in the easiest way.
        Task {
            do {
                if let profilePath = person.profilePath {
                    let imageUrl = URLBuilder.buildImageUrl(path: person.profilePath)
                    let data = try await HTTPClientImpl().performRequest(URLRequest(url: imageUrl!))
                    
                    self.imageView.image = UIImage(data: data.data)
                } else {
                    self.imageView.image = UIImage(systemName: "questionmark.circle")
                }
            } catch {
                print(error)
            }
        }
    }
}
