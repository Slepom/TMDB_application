
import Foundation
import UIKit
import SDWebImage


class UserCell: UICollectionViewCell, SelfConfiguringCell{
    
    static var reuseId: String = "UserCell"
    let name = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        name.font = UIFont.preferredFont(forTextStyle: .body)
        name.textColor = .label
        
        //imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        //
        let stackView = UIStackView(arrangedSubviews: [imageView, name])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        stackView.setCustomSpacing(10, after: imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: Result){
        name.text = result.title
        imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + result.posterPath)) ,completed: nil)
    }
    
    
}
