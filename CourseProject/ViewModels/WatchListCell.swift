
import Foundation
import SDWebImage

class WatchListCell: UITableViewCell{
    
    static var identifier = "MovieTableViewCell"

        private let posterView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .left
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return label
        }()
        
        private let releaseDateLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.textAlignment = .left
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            return label
        }()
        
        private let overviewLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 5
            label.textAlignment = .left
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            return label
        }()
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
        }
        
        override func layoutSubviews() {
            setupConstraints()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

        }
        
        public func configure(media: MoviesByGenre) {
            titleLabel.text = media.originalTitle
            let date = media.releaseDate ?? ""
            releaseDateLabel.text = String(date.dropLast(6))
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + (media.posterPath ?? "")) else { return }
            posterView.sd_setImage(with: url, completed: nil)
            overviewLabel.text = media.overview
        }
        
        private func setupConstraints() {
            contentView.addSubview(posterView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(overviewLabel)
            contentView.addSubview(releaseDateLabel)
            selectionStyle = .none
            backgroundColor = .clear
        

            NSLayoutConstraint.activate([
                
                posterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
                posterView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
                posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 1.5),
                
                titleLabel.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 8),
                titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                titleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
                
                releaseDateLabel.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 8),
                releaseDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
                releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                
                overviewLabel.leftAnchor.constraint(equalTo: posterView.rightAnchor, constant: 8),
                overviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
                overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8)
            ])
        }
}
