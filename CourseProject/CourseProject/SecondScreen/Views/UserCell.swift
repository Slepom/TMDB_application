
import Foundation
import UIKit



class UserCell: UICollectionViewCell, SelfConfiguringCell{
    
    static var reuseId: String = "UserCell"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with result: Result){
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        friendImageView.frame = self.bounds
        friendImageView.backgroundColor = .green
        friendImageView.clipsToBounds = true
        friendImageView.contentMode = .scaleAspectFit
        friendImageView.image = UIImage(named: result.posterPath)
    }
    func anyFunc(with intValue: Int){
        print("kjkjhkjh")
    }
    
}
