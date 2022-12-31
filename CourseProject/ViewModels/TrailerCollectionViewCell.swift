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
    var overView = UILabel()
    var vote = UILabel()
    var descriptionMoview = UILabel()
    //let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.youtubePlayer = YTPlayerView()
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.textColor = .white
        releaseDate.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        releaseDate.textColor = .white
        youtubePlayer.clipsToBounds = true
        youtubePlayer.frame = self.bounds
        overView.textColor = .white
        overView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        vote.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        vote.textColor = .white
        descriptionMoview.textColor = .white
        descriptionMoview.text = "Description"
        descriptionMoview.font = UIFont.systemFont(ofSize: 16, weight: .heavy)

        let stackView = UIStackView(arrangedSubviews: [youtubePlayer ,releaseDate, vote, descriptionMoview, overView])
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
        stackView.setCustomSpacing(10, after: vote)
        stackView.setCustomSpacing(10, after: releaseDate)
        stackView.setCustomSpacing(10, after: descriptionMoview)

        overView.lineBreakMode = .byWordWrapping
        overView.numberOfLines = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: MoviesByGenre){
        name.text = result.title
        releaseDate.text = "\(result.releaseDate ?? "unknown") release date"
        overView.text = result.overview
        vote.text = "IMDB \(result.voteAverage)"
    }
    
    
}
