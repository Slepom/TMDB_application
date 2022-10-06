
import Foundation
import UIKit



class UserCell: UICollectionViewCell, SelfConfiguringCell{
    
    static var reuseId: String = "UserCell"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        setupConstrains()
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstrains(){
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        friendImageView.frame = self.bounds
        friendImageView.backgroundColor = .green
    }
    func configure(with intValue: Int){
        print("kjkjhkjh")
    }
    
}
