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
    var name = UILabel()
    var releaseDate = UILabel()
    var genre = UILabel()
    var overView = UILabel()
    var vote = UILabel()
    //let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.youtubePlayer = YTPlayerView()
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.textColor = .label
        releaseDate.font = UIFont.preferredFont(forTextStyle: .body)
        releaseDate.textColor = .label
        genre.font = UIFont.preferredFont(forTextStyle: .body)
        genre.textColor = .label
        //overView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        youtubePlayer.clipsToBounds = true
        youtubePlayer.frame = self.bounds
        //overView.sizeToFit()
        overView.textColor = .label
        overView.font = UIFont.preferredFont(forTextStyle: .body)
       

        let stackView = UIStackView(arrangedSubviews: [youtubePlayer ,vote, genre, releaseDate, overView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(10, after: youtubePlayer)
        overView.lineBreakMode = .byWordWrapping
        overView.numberOfLines = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: MoviesByGenre){
        name.text = result.title
        releaseDate.text = result.releaseDate
        overView.text = result.overview
        vote.text = "IMDB rating \(result.voteAverage)"
    }
    
    
}
