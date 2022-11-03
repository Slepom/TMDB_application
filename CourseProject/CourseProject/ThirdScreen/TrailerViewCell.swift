

import youtube_ios_player_helper
import UIKit

class TrailerViewCell: UICollectionViewCell{
    
    static var reuseId: String = "TrailerViewCell"
    
    let youtubePlayer: YTPlayerView!
    let name = UILabel()
    let description = UITextField()
    let genre = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.textColor = .label
        description.font = UIFont.preferredFont(forTextStyle: .body)
        description.textColor = .label
        genre.textColor = .label
        genre.font = UIFont.preferredFont(forTextStyle: .body)

        
        //imageView.backgroundColor = .green
//        imageView.clipsToBounds = true
//        imageView.frame = self.bounds
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 30
        //
        let stackView = UIStackView(arrangedSubviews: [name,description, genre])
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
        description.text = result.releaseDate
        genre.text = result.overview
        //imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + result.posterPath)) ,completed: nil)
    }
    
    
    
}
