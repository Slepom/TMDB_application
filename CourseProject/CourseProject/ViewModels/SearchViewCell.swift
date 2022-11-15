

import UIKit
import UIKit
import SDWebImage

class SearchViewCell: UICollectionViewCell{
   
    static var reuseId = "SearchCell"
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let voteLabellet: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .green
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        return label
    }()
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        return label
    }()
    let overView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()

        
    }
    private func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        contentView.addSubview(subtitle)
        contentView.addSubview(overView)
        contentView.addSubview(voteLabellet)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.5),
            
            name.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            name.rightAnchor.constraint(equalTo: voteLabellet.leftAnchor, constant: -8),
            name.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            voteLabellet.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 4),
            voteLabellet.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            voteLabellet.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            subtitle.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            subtitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            subtitle.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            
            overView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            overView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            overView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: Movie){
        guard let posterPath = result.poster_path else{ return}
        imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + posterPath)) ,completed: nil)
        name.text = result.original_title ?? " "
        subtitle.text = result.release_date ?? " "
        overView.text = result.overview ?? " "
        
        voteLabellet.text = {
            if result.vote_average > 7.0{
                voteLabellet.textColor = .green
                return String(result.vote_average)

            }
                else {
                    voteLabellet.textColor = .red
                    return String(result.vote_average)
            }
        }()
    }
    
    
}

