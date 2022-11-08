

import UIKit
import UIKit
import SDWebImage

class SearchViewCell: UICollectionViewCell{
   
    static var reuseId = "SearchCell"
    let imageView = UIImageView()
    let name = UILabel()
    let subtitle = UILabel()
    let overView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel

        imageView.clipsToBounds = true
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
       // imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        //subtittle.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        overView.font = UIFont.preferredFont(forTextStyle: .body)
        overView.textColor = .green
//        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle, overView])
//        innerStackView.axis = .vertical
//        innerStackView.distribution = .equalCentering
        let otherStackView = UIStackView(arrangedSubviews: [imageView, name])
        otherStackView.translatesAutoresizingMaskIntoConstraints = false
        otherStackView.alignment = .center
        otherStackView.spacing = 20
        contentView.addSubview(otherStackView)

        NSLayoutConstraint.activate([
            otherStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            otherStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            otherStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            otherStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
       // otherStackView.setCustomSpacing(10, after: imageView)

        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: Movie){
        guard let posterPath = result.poster_path else{ return}
        imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + posterPath)) ,completed: nil)
        name.text = result.original_name ?? " "
        subtitle.text = result.release_date ?? " "
        overView.text = result.overview ?? " "
    }
    
    
}

