
import Foundation
import UIKit
import SDWebImage


class UserCell: UICollectionViewCell, SelfConfiguringCell{
    
    static var reuseId: String = "UserCell"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
        
        imageView.clipsToBounds = true
        imageView.frame = self.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        addSubview(imageView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: MoviesByGenre){
        imageView.sd_setImage(with:(URL(string:"https://image.tmdb.org/t/p/w500" + result.posterPath)) ,completed: nil)
    }
    
    
}
