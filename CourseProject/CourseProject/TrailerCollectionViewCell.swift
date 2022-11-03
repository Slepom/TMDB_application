//
//  TrailerCollectionViewCell.swift
//  CourseProject
//
//  Created by Полина Жарова on 3.11.22.
//

import UIKit
import youtube_ios_player_helper
class TrailerCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
    var youtubePlayer: YTPlayerView!
    static var reuseId: String = "TrailerCollectionViewCell"
    let name = UILabel()
    let releaseDate = UILabel()
    let genre = UILabel()
    //let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.textColor = .label
        releaseDate.font = UIFont.preferredFont(forTextStyle: .body)
        releaseDate.textColor = .label
        genre.font = UIFont.preferredFont(forTextStyle: .body)
        genre.textColor = .label
        //imageView.backgroundColor = .green
//        imageView.clipsToBounds = true
//        imageView.frame = self.bounds
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 30
        //
        let stackView = UIStackView(arrangedSubviews: [name, releaseDate, genre])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(10, after: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: MoviesByGenre){
        name.text = result.title
        releaseDate.text = result.releaseDate
        genre.text = result.title
       // imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + result.posterPath)) ,completed: nil)
    }
    
    
}
