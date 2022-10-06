
import Foundation
import UIKit
class NextCell: UICollectionViewCell, SelfConfiguringCell{
    
    static var reuseId: String = "NextCell"
    
    let friendImageView = UIImageView()
    let label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstrains()
        backgroundColor = .green
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupConstrains(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        addSubview(label)
        label.frame = self.bounds
        label.text = "1"
    }
    func configure(with intValue: Int){
        label.text = String(intValue)
    }
    
}
