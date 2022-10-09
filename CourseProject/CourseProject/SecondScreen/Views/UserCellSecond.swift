
import Foundation
import UIKit



class UserCellSecond: UICollectionViewCell, SelfConfiguringCell{
    func configure(with result: Result) {
        
    }
    
    
    static var reuseId: String = "UserCellSecond"
    
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        //setupConstrains()
        self.layer.cornerRadius = 15
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
    
    
}

